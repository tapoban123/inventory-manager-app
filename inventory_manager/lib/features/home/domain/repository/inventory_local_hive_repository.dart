abstract class InventoryLocalHiveRepository {
  Future<Map<String, String>?> fetchMaterialsFromInventory();
  Future<void> updateMaterialsInInventory(Map<String, String>? materials);
}
