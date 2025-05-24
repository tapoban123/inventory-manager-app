import 'package:inventory_manager/core/gsheet_config.dart';
import 'package:inventory_manager/features/home/data/datasources/inventory_datasource.dart';

class InventoryDatasourceImpl extends InventoryDatasource {
  @override
  Future<bool?> addtoInventory(Map<String, int> materials) async {
    final response = await inventoryGsheet?.values.insertRows(1, [
      materials.keys.toList(),
      materials.values.toList(),
    ]);

    return response;
  }

  @override
  Future<List<Map<String, String>>?> fetchFromInventory() async {
    final response = await inventoryGsheet?.values.map.allRows();
    return response;
  }

  @override
  Future<bool?> updateInventory(List<int> newQuantity) async {
    return await inventoryGsheet?.values.insertRow(2, newQuantity);
  }

  @override
  Future<bool?> removeFromInventory(String material) async {
    final index = await inventoryGsheet?.values.columnIndexOf(material);
    return inventoryGsheet?.deleteColumn(index!);
  }
}
