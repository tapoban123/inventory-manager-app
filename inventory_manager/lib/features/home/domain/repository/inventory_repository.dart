abstract class InventoryRepository {
  Future<bool?> addMaterialToInventory(Map<String, int> materials);
  Future<bool?> updateQuantityInventory(List<int> newQuantity);
  Future<bool?> removeMaterialFromInventory(String material);
  Future<Map<String, String>?> fetchAllFromInventory();
}
