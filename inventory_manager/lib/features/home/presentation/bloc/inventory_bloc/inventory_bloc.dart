import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_local_hive_usecases/fetch_all_materials_from_localdb.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_local_hive_usecases/update_materials_in_localdb.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_usecases/add_material_to_inventory.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_usecases/fetch_all_from_inventory.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_usecases/remove_material_from_inventory.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_usecases/update_quantity_in_inventory.dart';
import 'package:inventory_manager/features/home/presentation/bloc/inventory_bloc/inventory_events.dart';
import 'package:inventory_manager/features/home/presentation/bloc/inventory_bloc/inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvents, InventoryStates> {
  final AddMaterialToInventory _addMaterialToInventory;
  final UpdateQuantityInInventory _updateQuantityInInventory;
  final FetchAllFromInventory _fetchAllFromInventory;
  final RemoveMaterialFromInventory _removeMaterialFromInventory;
  final FetchAllMaterialsFromLocaldb _fetchAllMaterialsFromLocaldb;
  final UpdateMaterialsInLocaldb _updateMaterialsInLocaldb;

  InventoryBloc({
    required AddMaterialToInventory addMaterialToInventory,
    required UpdateQuantityInInventory updateQuantityInInventory,
    required RemoveMaterialFromInventory removeMaterialFromInventory,
    required FetchAllFromInventory fetchAllFromInventory,
    required FetchAllMaterialsFromLocaldb fetchAllMaterialsFromLocaldb,
    required UpdateMaterialsInLocaldb updateMaterialsInLocaldb,
  }) : _addMaterialToInventory = addMaterialToInventory,
       _fetchAllFromInventory = fetchAllFromInventory,
       _removeMaterialFromInventory = removeMaterialFromInventory,
       _updateQuantityInInventory = updateQuantityInInventory,
       _fetchAllMaterialsFromLocaldb = fetchAllMaterialsFromLocaldb,
       _updateMaterialsInLocaldb = updateMaterialsInLocaldb,
       super(InventoryStates(loadingStatus: InventoryLoadingStatus.initial)) {
    on<AddToInventoryEvent>(addToInventory);
    on<UpdateInventoryEvent>(updateInventory);
    on<FetchFromInventoryEvent>(fetchFromInventory);
    on<RemoveFromInventoryEvent>(removeFromInventory);
  }

  void addToInventory(AddToInventoryEvent event, Emitter emit) {
    _addMaterialToInventory.call(event.newItem);
    final updatedMaterials = event.newItem.map(
      (key, value) => MapEntry(key, value.toString()),
    );
    _updateMaterialsInLocaldb.call(updatedMaterials);
    emit(state.copyWith(inventoryData: updatedMaterials));
  }

  void updateInventory(UpdateInventoryEvent event, Emitter emit) async {
    _updateQuantityInInventory.call(event.newQuantities);

    final Map<String, String> updatedMaterials = {};
    List<String> materialKeys = state.inventoryData!.keys.toList();

    for (int i = 0; i < materialKeys.length; i++) {
      updatedMaterials[materialKeys[i]] = (event.newQuantities[i]).toString();
    }

    _updateMaterialsInLocaldb.call(updatedMaterials);
  }

  void fetchFromInventory(FetchFromInventoryEvent event, Emitter emit) async {
    emit(state.copyWith(loadingStatus: InventoryLoadingStatus.loading));

    Map<String, String>? dataInLocalDb =
        await _fetchAllMaterialsFromLocaldb.call();

    if (dataInLocalDb == null) {
      log("Data fetching from sheets.");
      final data = await _fetchAllFromInventory.call();
      await _updateMaterialsInLocaldb.call(data);
      dataInLocalDb = await _fetchAllFromInventory.call();
    }
    log("Working fetch");
    log(dataInLocalDb.toString());
    log("State = ${state.inventoryData}");

    emit(state.copyWith(loadingStatus: InventoryLoadingStatus.success));
    emit(state.copyWith(inventoryData: Map<String, String>.from(dataInLocalDb ?? {})));
    emit(state.copyWith(inventoryData: Map<String, String>.from(dataInLocalDb ?? {})));
  }

  void removeFromInventory(RemoveFromInventoryEvent event, Emitter emit) {
    _removeMaterialFromInventory.call(event.item);

    Map<String, String> deepCopyData = state.inventoryData!.cast();

    deepCopyData.remove(event.item);

    _updateMaterialsInLocaldb.call(deepCopyData);

    emit(state.copyWith(inventoryData: deepCopyData));
  }
}
