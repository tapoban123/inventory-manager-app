import 'package:inventory_manager/features/home/domain/repository/inventory_local_hive_repository.dart';

class UpdateMaterialsInLocaldb {
  final InventoryLocalHiveRepository _inventoryLocalHiveRepository;
  UpdateMaterialsInLocaldb({
    required InventoryLocalHiveRepository inventoryLocalHiveRepository,
  }) : _inventoryLocalHiveRepository = inventoryLocalHiveRepository;

  Future<void> call(Map<String, String>? materials) async {
    await _inventoryLocalHiveRepository.updateMaterialsInInventory(materials);
  }
}
