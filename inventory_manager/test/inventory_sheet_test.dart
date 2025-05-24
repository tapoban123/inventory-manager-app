import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_manager/core/gsheet_config.dart';
import 'package:inventory_manager/features/home/data/datasources/inventory/inventory_datasource_impl.dart';

void main() {
  setUp(() async {
    await gSheetInitialise();
  });
  test("add items to inventory sheet", () async {
    final inventory = InventoryDatasourceImpl();
    final testData = {
      "wood": 500,
      "steel": 0,
      "foam": 7,
      "screws": 1000,
      "fabric": 6,
      "plastic": 200,
      "meds": 30,
    };

    final result = await inventory.addtoInventory(testData);
    print(result);
  });
  test("fetch items from inventory sheet", () async {
    final inventory = InventoryDatasourceImpl();

    final result = await inventory.fetchFromInventory();
    print(result);
  });
  test("update items from inventory sheet", () async {
    final inventory = InventoryDatasourceImpl();

    final result = await inventory.updateInventory([]);
    print(result);
  });
  test("delete item from inventory sheet", () async {
    final inventory = InventoryDatasourceImpl();

    final result = await inventory.removeFromInventory("fabric");
    print(result);
  });
}
