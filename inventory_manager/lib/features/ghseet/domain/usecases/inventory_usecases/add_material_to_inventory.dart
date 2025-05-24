import 'package:inventory_manager/features/ghseet/domain/repository/inventory_repository.dart';

class AddMaterialToInventory {
  final InventoryRepository _inventoryRepository;

  AddMaterialToInventory({required InventoryRepository inventoryRepository})
    : _inventoryRepository = inventoryRepository;

  Future<bool?> call(Map<String, int> materials) async {
    return await _inventoryRepository.addMaterialToInventory(materials);
  }
}
