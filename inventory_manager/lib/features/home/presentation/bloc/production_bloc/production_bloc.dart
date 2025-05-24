import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/core/exceptions.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_usecases/fetch_all_from_inventory.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_usecases/update_quantity_in_inventory.dart';
import 'package:inventory_manager/features/home/domain/usecases/products_usecases/fetch_all_products.dart';
import 'package:inventory_manager/features/home/domain/usecases/products_usecases/set_production_count.dart';
import 'package:inventory_manager/features/home/presentation/bloc/production_bloc/production_events.dart';
import 'package:inventory_manager/features/home/presentation/bloc/production_bloc/production_states.dart';

class ProductionBloc extends Bloc<ProductionEvents, ProductionStates> {
  final FetchAllProducts _fetchAllProducts;
  final SetProductionCount _setProductionCount;
  final UpdateQuantityInInventory _updateQuantityInInventory;
  final FetchAllFromInventory _fetchAllFromInventory;

  ProductionBloc({
    required FetchAllProducts fetchAllProducts,
    required SetProductionCount setProductionCount,
    required UpdateQuantityInInventory updateQuantityInInventory,
    required FetchAllFromInventory fetchAllFromInventory,
  }) : _fetchAllProducts = fetchAllProducts,
       _setProductionCount = setProductionCount,
       _updateQuantityInInventory = updateQuantityInInventory,
       _fetchAllFromInventory = fetchAllFromInventory,
       super(ProductionStates()) {
    on<FetchAllProductsEvent>(fetchAllProductsFromSheet);
    on<IncreaseProductionCountEvent>(increaseProductionCount);
    on<DecreaseProductionCountEvent>(decreaseProductionCount);
  }

  void fetchAllProductsFromSheet(
    FetchAllProductsEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(loadingStatus: ProductionLoadingStatus.loading));
    final products = await _fetchAllProducts.call();
    emit(
      state.copyWith(
        loadingStatus: ProductionLoadingStatus.success,
        productionData: products,
      ),
    );
  }

  void increaseProductionCount(
    IncreaseProductionCountEvent event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(loadingStatus: ProductionLoadingStatus.increasingCount),
    );

    final deepCopyData =
        state.productionData?.map((e) => Map<String, String>.from(e)).toList();
    for (final product in deepCopyData!) {
      if (product["composition_id"] == event.compositionId) {
        product["count"] = event.newCount;
      }
    }

    await _setProductionCount.call(event.compositionId, event.newCount);

    final inventoryData = (await _fetchAllFromInventory())?[0] ?? {};
    final keys = inventoryData.keys.toList();
    final presentQuantity = inventoryData.values.toList();
    final amountToBeDeductedPerMaterial = {};

    for (int i = 0; i < keys.length; i++) {
      amountToBeDeductedPerMaterial[keys[i]] =
          int.parse(event.materials.values.toList()[i]) * event.countIncreased;
    }

    final newQuantity = amountToBeDeductedPerMaterial.values.toList();
    final updatedInventory = {};

    for (int i = 0; i < keys.length; i++) {
      if (int.parse(presentQuantity[i]) > newQuantity[i]) {
        updatedInventory[keys[i]] =
            int.parse(presentQuantity[i]) - newQuantity[i];
      } else {
        throw InsufficientResources();
      }
    }

    await _updateQuantityInInventory.call(
      updatedInventory.values.toList() as List<int>,
    );

    emit(
      state.copyWith(
        loadingStatus: ProductionLoadingStatus.increaseDone,
        productionData: deepCopyData,
      ),
    );
  }

  void decreaseProductionCount(
    DecreaseProductionCountEvent event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(loadingStatus: ProductionLoadingStatus.decreasingCount),
    );
    final deepCopyData =
        state.productionData?.map((e) => Map<String, String>.from(e)).toList();
    for (final product in deepCopyData!) {
      if (product["composition_id"] == event.compositionId) {
        product["count"] = event.newCount;
      }
    }

    await _setProductionCount.call(event.compositionId, event.newCount);

    final inventoryData = (await _fetchAllFromInventory())?[0] ?? {};
    final keys = inventoryData.keys.toList();
    final presentQuantity = inventoryData.values.toList();
    final amountToBeDeductedPerMaterial = {};

    for (int i = 0; i < keys.length; i++) {
      amountToBeDeductedPerMaterial[keys[i]] =
          int.parse(event.materials.values.toList()[i]) * event.countDecreased;
    }

    final newQuantity = amountToBeDeductedPerMaterial.values.toList();
    final updatedInventory = {};

    for (int i = 0; i < keys.length; i++) {
      updatedInventory[keys[i]] =
          int.parse(presentQuantity[i]) + newQuantity[i];
    }

    await _updateQuantityInInventory.call(
      updatedInventory.values.toList() as List<int>,
    );

    emit(state.copyWith(loadingStatus: ProductionLoadingStatus.decreaseDone));
  }
}
