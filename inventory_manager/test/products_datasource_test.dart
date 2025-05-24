import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_manager/core/gsheet_config.dart';
import 'package:inventory_manager/features/home/data/datasources/products/products_datasource_impl.dart';

void main() {
  setUp(() async {
    await gSheetInitialise();
  });
  test("set new product count", () async {
    final productsDatasource = ProductsDatasourceImpl();
    final response = await productsDatasource.setProductCount("125", "10");
    print(response);
  });
  test("fetch all products", () async {
    final productsDatasource = ProductsDatasourceImpl();
    final response = await productsDatasource.fetchAllProducts();
    print(response);
  });
}
