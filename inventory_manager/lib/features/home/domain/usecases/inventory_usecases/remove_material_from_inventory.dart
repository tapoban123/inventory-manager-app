import 'package:inventory_manager/features/home/domain/repository/inventory_repository.dart';

class RemoveMaterialFromInventory {
  final InventoryRepository _inventoryRepository;

  RemoveMaterialFromInventory({
    required InventoryRepository inventoryRepository,
  }) : _inventoryRepository = inventoryRepository;

  Future<bool?> call(String material) async {
    return _inventoryRepository.removeMaterialFromInventory(material);
  }
}
