abstract class ProductsRepository {
  Future<bool?> setProductCount(String compositionId, String newCount);
  Future<List<Map<String, String>>?> fetchAllProducts();
}
