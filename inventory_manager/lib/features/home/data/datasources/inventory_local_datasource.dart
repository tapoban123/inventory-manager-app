abstract class InventoryLocalDatasource {
  Future<Map<dynamic, dynamic>?> fetchMaterialsFromInventory();
  Future<void> updateMaterialsInInventory(Map<String, String>? materials);
}
