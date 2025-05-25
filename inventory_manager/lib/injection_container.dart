import 'package:inventory_manager/features/home/data/datasources/inventory_local_datasource.dart';
import 'package:inventory_manager/features/home/data/datasources/local_hive/inventory_local_datasource_impl.dart';
import 'package:inventory_manager/features/home/data/repository/inventory_local_hive_repository_impl.dart';
import 'package:inventory_manager/features/home/domain/repository/inventory_local_hive_repository.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_local_hive_usecases/fetch_all_materials_from_localdb.dart';
import 'package:inventory_manager/features/home/domain/usecases/inventory_local_hive_usecases/update_materials_in_localdb.dart';
import 'package:inventory_manager/injection_container_imports.dart';

final getIt = GetIt.instance;

void init() {
  // blocs
  getIt.registerFactory(
    () => InventoryBloc(
      addMaterialToInventory: getIt(),
      updateQuantityInInventory: getIt(),
      removeMaterialFromInventory: getIt(),
      fetchAllFromInventory: getIt(),
      fetchAllMaterialsFromLocaldb: getIt(),
      updateMaterialsInLocaldb: getIt(),
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

  // inventory localDB usecases
  getIt.registerLazySingleton(
    () => FetchAllMaterialsFromLocaldb(inventoryLocalHiveRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => UpdateMaterialsInLocaldb(inventoryLocalHiveRepository: getIt()),
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
  getIt.registerLazySingleton<InventoryLocalHiveRepository>(
    () => InventoryLocalHiveRepositoryImpl(inventoryLocalDatasource: getIt()),
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
  getIt.registerLazySingleton<InventoryLocalDatasource>(
    () => InventoryLocalDatasourceImpl(),
  );
}
