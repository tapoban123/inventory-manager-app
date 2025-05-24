import 'package:inventory_manager/core/gsheet_config.dart';
import 'package:inventory_manager/features/home/data/datasources/products_datasource.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  @override
  Future<bool?> setProductCount(String compositionId, String newCount) async {
    final index = await compositionGsheet?.values.rowIndexOf(compositionId);
    final response = compositionGsheet?.values.map.insertRow(index!, {
      "count": newCount,
    });
    return response;
  }

  @override
  Future<List<Map<String, String>>?> fetchAllProducts() async {
    final response = await compositionGsheet?.values.map.allColumns(fromRow: 2);
    return response;
  }
}
