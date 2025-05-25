import 'package:hive_flutter/adapters.dart';
import 'package:inventory_manager/core/utils/utils.dart';
import 'package:inventory_manager/features/home/data/datasources/inventory_local_datasource.dart';

class InventoryLocalDatasourceImpl extends InventoryLocalDatasource {
  late Box _hiveBox;
  final String _inventoryKey = HiveKeys.inventoryKey.name;

  Future<void> _initHive() async {
    final String box = HiveBoxName.inventoryBox.name;
    _hiveBox = await Hive.openBox(box);
  }

  @override
  Future<Map<dynamic, dynamic>?> fetchMaterialsFromInventory() async {
    await _initHive();
    final  inventoryData = await _hiveBox.get(
      _inventoryKey,
    );
    await _hiveBox.close();

    return inventoryData;
  }

  @override
  Future<void> updateMaterialsInInventory(Map<String, String>? materials) async {
    await _initHive();
    await _hiveBox.put(_inventoryKey, materials);
    await _hiveBox.close();
  }
}
