import 'package:inventory_manager/features/ghseet/domain/repository/inventory_repository.dart';

class UpdateQuantityInInventory {
  final InventoryRepository _inventoryRepository;

  UpdateQuantityInInventory({required InventoryRepository inventoryRepository})
    : _inventoryRepository = inventoryRepository;

  Future<bool?> call(List<int> newQuantity) async {
    return _inventoryRepository.updateQuantityInventory(newQuantity);
  }
}
