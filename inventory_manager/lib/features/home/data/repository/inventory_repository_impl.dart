import 'dart:developer' show log;

import 'package:inventory_manager/features/home/data/datasources/inventory_datasource.dart';
import 'package:inventory_manager/features/home/domain/repository/inventory_repository.dart';

class InventoryRepositoryImpl extends InventoryRepository {
  final InventoryDatasource _inventoryDatasource;
  InventoryRepositoryImpl({required InventoryDatasource inventoryDatasource})
    : _inventoryDatasource = inventoryDatasource;

  @override
  Future<bool?> addMaterialToInventory(Map<String, int> materials) async {
    try {
      final response = await _inventoryDatasource.addtoInventory(materials);
      return response;
    } catch (e) {
      log("Add Material to Inventory Error: $e");

      return null;
    }
  }

  @override
  Future<Map<String, String>?> fetchAllFromInventory() async {
    try {
      final materials = await _inventoryDatasource.fetchFromInventory();
      return materials?[0];
    } catch (e) {
      log("Fetch from Inventory Error: $e");

      return null;
    }
  }

  @override
  Future<bool?> removeMaterialFromInventory(String material) async {
    try {
      final response = await _inventoryDatasource.removeFromInventory(material);
      return response;
    } catch (e) {
      log("Remove material from Inventory Error: $e");

      return null;
    }
  }

  @override
  Future<bool?> updateQuantityInventory(List<int> newQuantity) async {
    try {
      final response = await _inventoryDatasource.updateInventory(newQuantity);
      return response;
    } catch (e) {
      log("Update quantity in Inventory Error: $e");

      return null;
    }
  }
}
