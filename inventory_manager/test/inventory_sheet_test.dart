import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_manager/core/gsheet_config.dart';
import 'package:inventory_manager/features/ghseet/data/datasources/inventory/inventory_datasource_impl.dart';

void main() {
  setUp(() async {
    await gSheetInitialise();
  });
  test("add items to inventory sheet", () async {
    final inventory = InventoryDatasourceImpl();

    final result = await inventory.addtoInventory({});
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

    final result = await inventory.removeFromInventory("");
    print(result);
  });
}
