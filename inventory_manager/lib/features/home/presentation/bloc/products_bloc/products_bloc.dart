import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_local_hive_usecases/update_materials_in_localdb.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_usecases/fetch_all_from_inventory.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_usecases/update_quantity_in_inventory.dart';
import 'package:inventory_manager/features/home/domain/usecases/products_usecases/fetch_all_products.dart';
import 'package:inventory_manager/features/home/domain/usecases/products_usecases/set_production_count.dart';
import 'package:inventory_manager/features/home/presentation/bloc/products_bloc/products_events.dart';
import 'package:inventory_manager/features/home/presentation/bloc/products_bloc/products_states.dart';

class ProductsBloc extends Bloc<ProductionEvents, ProductsStates> {
  final FetchAllProducts _fetchAllProducts;
  final SetProductionCount _setProductionCount;
  final UpdateQuantityInInventory _updateQuantityInInventory;
  final FetchAllFromInventory _fetchAllFromInventory;
  final UpdateMaterialsInLocaldb _updateMaterialsInLocaldb;

  ProductsBloc({
    required FetchAllProducts fetchAllProducts,
    required SetProductionCount setProductionCount,
    required UpdateQuantityInInventory updateQuantityInInventory,
    required FetchAllFromInventory fetchAllFromInventory,
    required UpdateMaterialsInLocaldb updateMaterialsInLocaldb,
  }) : _fetchAllProducts = fetchAllProducts,
       _setProductionCount = setProductionCount,
       _updateQuantityInInventory = updateQuantityInInventory,
       _fetchAllFromInventory = fetchAllFromInventory,
       _updateMaterialsInLocaldb = updateMaterialsInLocaldb,
       super(ProductsStates()) {
    on<FetchAllProductsEvent>(fetchAllProductsFromSheet);
    on<IncreaseProductsCountEvent>(increaseProductionCount);
    // on<DecreaseProductsCountEvent>(decreaseProductionCount);
  }

  void fetchAllProductsFromSheet(
    FetchAllProductsEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(loadingStatus: ProductsLoadingStatus.loading));
    final products = await _fetchAllProducts.call();
    emit(
      state.copyWith(
        loadingStatus: ProductsLoadingStatus.success,
        productsData: products ?? [],
      ),
    );
  }

  void increaseProductionCount(
    IncreaseProductsCountEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(loadingStatus: ProductsLoadingStatus.loading));

    bool isInsufficientResources = false;

    final inventoryData = (await _fetchAllFromInventory()) ?? {};
    final keys = inventoryData.keys.toList();
    final presentQuantity = inventoryData.values.toList();
    final Map<String, int> amountToBeDeductedPerMaterial = {};

    for (int i = 0; i < keys.length; i++) {
      amountToBeDeductedPerMaterial[keys[i]] =
          int.parse(event.materials.values.toList()[i]) * event.countIncreased;
    }

    final newQuantity = amountToBeDeductedPerMaterial.values.toList();
    final Map<String, String> updatedInventory = {};

    for (int i = 0; i < keys.length; i++) {
      if (int.parse(presentQuantity[i]) > newQuantity[i]) {
        updatedInventory[keys[i]] =
            (int.parse(presentQuantity[i]) - newQuantity[i]).toString();
      } else {
        isInsufficientResources = true;
        break;
      }
    }

    if (isInsufficientResources) {
      emit(state.copyWith(error: "INSUFFICIENT RESOURCES"));
      emit(state.copyWith(error: ""));
    } else {
      final deepCopyData =
          state.productsData?.map((e) => Map<String, String>.from(e)).toList();

      for (final product in deepCopyData!) {
        if (product["composition_id"] == event.compositionId) {
          product["count"] = event.newCount;
        }
      }

      await _updateMaterialsInLocaldb.call(updatedInventory);
      
      await _setProductionCount.call(event.compositionId, event.newCount);
      await _updateQuantityInInventory.call(
        updatedInventory.values.toList().map((e) => int.parse(e)).toList(),
      );
      

      emit(
        state.copyWith(
          loadingStatus: ProductsLoadingStatus.success,
          productsData: deepCopyData,
        ),
      );
    }

    emit(state.copyWith(loadingStatus: ProductsLoadingStatus.success));
  }

  // void decreaseProductionCount(
  //   DecreaseProductsCountEvent event,
  //   Emitter emit,
  // ) async {
  //   emit(state.copyWith(loadingStatus: ProductsLoadingStatus.loading));

  //   final deepCopyData =
  //       state.productsData?.map((e) => Map<String, String>.from(e)).toList();
  //   for (final product in deepCopyData!) {
  //     if (product["composition_id"] == event.compositionId) {
  //       product["count"] = event.newCount;
  //     }
  //   }

  //   await _setProductionCount.call(event.compositionId, event.newCount);

  //   final Map<String, String> inventoryData =
  //       (await _fetchAllFromInventory()) ?? {};
  //   final keys = inventoryData.keys.toList();
  //   final presentQuantity = inventoryData.values.toList();
  //   final Map<String, int> amountToBeIncreasedPerMaterial = {};

  //   for (int i = 0; i < keys.length; i++) {
  //     amountToBeIncreasedPerMaterial[keys[i]] =
  //         int.parse(event.materials.values.toList()[i]) * event.countDecreased;
  //   }

  //   final newQuantity = amountToBeIncreasedPerMaterial.values.toList();
  //   final Map<String, String> updatedInventory = {};

  //   for (int i = 0; i < keys.length; i++) {
  //     updatedInventory[keys[i]] =
  //         (int.parse(presentQuantity[i]) + newQuantity[i]).toString();
  //   }

  //   await _updateQuantityInInventory.call(
  //     updatedInventory.values.toList().map((e) => int.parse(e)).toList(),
  //   );

  //   emit(state.copyWith(loadingStatus: ProductsLoadingStatus.success));
  // }
}
