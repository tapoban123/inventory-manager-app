import 'package:get_it/get_it.dart';
import 'package:inventory_manager/features/home/data/datasources/composition/composition_sheet_datasource_impl.dart';
import 'package:inventory_manager/features/home/data/datasources/composition_sheet_datasource.dart';
import 'package:inventory_manager/features/home/data/datasources/inventory/inventory_datasource_impl.dart';
import 'package:inventory_manager/features/home/data/datasources/inventory_datasource.dart';
import 'package:inventory_manager/features/home/data/datasources/products/products_datasource_impl.dart';
import 'package:inventory_manager/features/home/data/datasources/products_datasource.dart';
import 'package:inventory_manager/features/home/data/repository/composition_respository_impl.dart';
import 'package:inventory_manager/features/home/data/repository/inventory_repository_impl.dart';
import 'package:inventory_manager/features/home/data/repository/products_repository_impl.dart';
import 'package:inventory_manager/features/home/domain/repository/composition_repository.dart';
import 'package:inventory_manager/features/home/domain/repository/inventory_repository.dart';
import 'package:inventory_manager/features/home/domain/repository/products_repository.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/create_new_composition.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/fetch_all_compositions.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/fetch_specific_composition.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/remove_composition.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/add_composition_material.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/remove_composition_material.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/update_composition.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_usecases/add_material_to_inventory.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_usecases/fetch_all_from_inventory.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_usecases/remove_material_from_inventory.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_usecases/update_quantity_in_inventory.dart';
import 'package:inventory_manager/features/home/domain/usecases/products_usecases/fetch_all_products.dart';
import 'package:inventory_manager/features/home/domain/usecases/products_usecases/set_production_count.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/products_bloc/products_bloc.dart';

final getIt = GetIt.instance;

void init() {
  // blocs
  getIt.registerFactory(
    () => InventoryBloc(
      addMaterialToInventory: getIt(),
      updateQuantityInInventory: getIt(),
      removeMaterialFromInventory: getIt(),
      fetchAllFromInventory: getIt(),
    ),
  );
  getIt.registerFactory(
    () => CompositionBloc(
      createNewComposition: getIt(),
      fetchAllCompositions: getIt(),
      fetchSpecificComposition: getIt(),
      removeComposition: getIt(),
      addCompositionMaterial: getIt(),
      removeCompositionMaterial: getIt(),
      updateComposition: getIt(),
    ),
  );
  getIt.registerFactory(
    () => ProductsBloc(
      fetchAllProducts: getIt(),
      setProductionCount: getIt(),
      updateQuantityInInventory: getIt(),
      fetchAllFromInventory: getIt(),
    ),
  );

  // Inventory usecases
  getIt.registerLazySingleton(
    () => AddMaterialToInventory(inventoryRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => UpdateQuantityInInventory(inventoryRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => RemoveMaterialFromInventory(inventoryRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => FetchAllFromInventory(inventoryRepository: getIt()),
  );

  // Composition usecases
  getIt.registerLazySingleton(
    () => CreateNewComposition(compositionRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => FetchAllCompositions(compositionRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => FetchSpecificComposition(compositionRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => RemoveComposition(compositionRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => AddCompositionMaterial(compositionRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => RemoveCompositionMaterial(compositionRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => UpdateComposition(compositionRepository: getIt()),
  );

  // products usecases
  getIt.registerLazySingleton(
    () => FetchAllProducts(productsRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => SetProductionCount(productsRepository: getIt()),
  );

  // repositories
  getIt.registerLazySingleton<InventoryRepository>(
    () => InventoryRepositoryImpl(inventoryDatasource: getIt()),
  );
  getIt.registerLazySingleton<CompositionRepository>(
    () => CompositionRespositoryImpl(compositionSheetDatasource: getIt()),
  );
  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(productsDatasource: getIt()),
  );

  // datasources
  getIt.registerLazySingleton<InventoryDatasource>(
    () => InventoryDatasourceImpl(),
  );
  getIt.registerLazySingleton<CompositionSheetDatasource>(
    () => CompositionSheetDatasourceImpl(),
  );
  getIt.registerLazySingleton<ProductsDatasource>(
    () => ProductsDatasourceImpl(),
  );
}
