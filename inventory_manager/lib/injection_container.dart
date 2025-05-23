import 'package:get_it/get_it.dart';
import 'package:inventory_manager/features/ghseet/data/datasources/inventory/inventory_datasource_impl.dart';
import 'package:inventory_manager/features/ghseet/data/datasources/inventory_datasource.dart';
import 'package:inventory_manager/features/ghseet/data/repository/inventory_repository_impl.dart';
import 'package:inventory_manager/features/ghseet/domain/repository/inventory_repository.dart';
import 'package:inventory_manager/features/ghseet/domain/usecases/add_material_to_inventory.dart';
import 'package:inventory_manager/features/ghseet/domain/usecases/fetch_all_from_inventory.dart';
import 'package:inventory_manager/features/ghseet/domain/usecases/remove_material_from_inventory.dart';
import 'package:inventory_manager/features/ghseet/domain/usecases/update_quantity_in_inventory.dart';
import 'package:inventory_manager/features/ghseet/presentation/bloc/inventory_bloc/inventory_bloc.dart';

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

  // usecases
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

  // repositories
  getIt.registerLazySingleton<InventoryRepository>(
    () => InventoryRepositoryImpl(inventoryDatasource: getIt()),
  );

  // datasources
  getIt.registerLazySingleton<InventoryDatasource>(
    () => InventoryDatasourceImpl(),
  );
}
