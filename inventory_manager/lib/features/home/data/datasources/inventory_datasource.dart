abstract class InventoryDatasource {
  Future<bool?> addtoInventory(Map<String, int> materials);
  Future<bool?> updateInventory(List<int> newQuantity);
  Future<bool?> removeFromInventory(String material);
  Future<List<Map<String, String>>?> fetchFromInventory();
}
