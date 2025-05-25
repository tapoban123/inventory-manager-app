import 'package:inventory_manager/features/home/domain/repository/inventory_local_hive_repository.dart';

class FetchAllMaterialsFromLocaldb {
  final InventoryLocalHiveRepository _inventoryLocalHiveRepository;
  FetchAllMaterialsFromLocaldb({
    required InventoryLocalHiveRepository inventoryLocalHiveRepository,
  }) : _inventoryLocalHiveRepository = inventoryLocalHiveRepository;

  Future<Map<String, String>?> call() async {
    return await _inventoryLocalHiveRepository.fetchMaterialsFromInventory();
  }
}
