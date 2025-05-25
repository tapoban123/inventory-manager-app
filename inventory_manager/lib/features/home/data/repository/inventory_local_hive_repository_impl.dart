import 'dart:developer' show log;

import 'package:inventory_manager/features/home/data/datasources/inventory_local_datasource.dart';
import 'package:inventory_manager/features/home/domain/repository/inventory_local_hive_repository.dart';

class InventoryLocalHiveRepositoryImpl extends InventoryLocalHiveRepository {
  final InventoryLocalDatasource _inventoryLocalDatasource;
  InventoryLocalHiveRepositoryImpl({
    required InventoryLocalDatasource inventoryLocalDatasource,
  }) : _inventoryLocalDatasource = inventoryLocalDatasource;

  @override
  Future<Map<String, String>?> fetchMaterialsFromInventory() async {
    try {
      final response =
          await _inventoryLocalDatasource.fetchMaterialsFromInventory();

      if (response != null) {
        final inventoryData = response.cast<String, String>();
        return inventoryData;
      }
      return null;
    } catch (e) {
      log("Hive Fetching Error: $e");
      return null;
    }
  }

  @override
  Future<void> updateMaterialsInInventory(
    Map<String, String>? materials,
  ) async {
    try {
      await _inventoryLocalDatasource.updateMaterialsInInventory(materials);
    } catch (e) {
      log("Hive Update Error: $e");
    }
  }
}
