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
