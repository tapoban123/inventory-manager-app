import 'package:flutter_bloc/flutter_bloc.dart';
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

  InventoryBloc({
    required AddMaterialToInventory addMaterialToInventory,
    required UpdateQuantityInInventory updateQuantityInInventory,
    required RemoveMaterialFromInventory removeMaterialFromInventory,
    required FetchAllFromInventory fetchAllFromInventory,
  }) : _addMaterialToInventory = addMaterialToInventory,
       _fetchAllFromInventory = fetchAllFromInventory,
       _removeMaterialFromInventory = removeMaterialFromInventory,
       _updateQuantityInInventory = updateQuantityInInventory,
       super(InventoryStates(loadingStatus: InventoryLoadingStatus.initial)) {
    on<AddToInventoryEvent>(addToInventory);
    on<UpdateInventoryEvent>(updateInventory);
    on<FetchFromInventoryEvent>(fetchFromInventory);
    on<RemoveFromInventoryEvent>(removeFromInventory);
  }

  void addToInventory(AddToInventoryEvent event, Emitter emit) {
    _addMaterialToInventory.call(event.newItem);
    emit(
      state.copyWith(
        inventoryData: [
          event.newItem.map((key, value) => MapEntry(key, value.toString())),
        ],
      ),
    );
  }

  void updateInventory(UpdateInventoryEvent event, Emitter emit) async {
    _updateQuantityInInventory.call(event.newQuantities);
  }

  void fetchFromInventory(FetchFromInventoryEvent event, Emitter emit) async {
    emit(state.copyWith(loadingStatus: InventoryLoadingStatus.loading));
    final data = await _fetchAllFromInventory.call();
    emit(
      state.copyWith(
        loadingStatus: InventoryLoadingStatus.success,
        inventoryData: data,
      ),
    );
  }

  void removeFromInventory(RemoveFromInventoryEvent event, Emitter emit) {
    _removeMaterialFromInventory.call(event.item);

    List<Map<String, String>> deepCopyData =
        state.inventoryData!.map((e) => Map<String, String>.from(e)).toList();

    deepCopyData[0].remove(event.item);

    emit(state.copyWith(inventoryData: deepCopyData));
  }
}
