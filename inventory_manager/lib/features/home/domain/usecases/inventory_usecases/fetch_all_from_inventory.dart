import 'package:inventory_manager/features/home/domain/repository/inventory_repository.dart';

class FetchAllFromInventory {
  final InventoryRepository _inventoryRepository;

  FetchAllFromInventory({required InventoryRepository inventoryRepository})
    : _inventoryRepository = inventoryRepository;

  Future<Map<String, String>?> call() async {
    return await _inventoryRepository.fetchAllFromInventory();
  }
}
