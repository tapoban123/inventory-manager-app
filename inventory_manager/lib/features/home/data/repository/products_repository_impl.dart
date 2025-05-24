import 'package:inventory_manager/features/home/data/datasources/products_datasource.dart';
import 'package:inventory_manager/features/home/domain/repository/products_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsDatasource _productsDatasource;
  ProductsRepositoryImpl({required ProductsDatasource productsDatasource})
    : _productsDatasource = productsDatasource;

  @override
  Future<List<Map<String, String>>?> fetchAllProducts() async {
    try {
      final response = await _productsDatasource.fetchAllProducts();
      return response;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool?> setProductCount(String compositionId, String newCount) async {
    try {
      final response = await _productsDatasource.setProductCount(
        compositionId,
        newCount,
      );
      return response;
    } catch (e) {
      return null;
    }
  }
}
