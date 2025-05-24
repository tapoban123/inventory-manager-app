import 'package:inventory_manager/features/home/domain/repository/products_repository.dart';

class SetProductionCount {
  final ProductsRepository _productsRepository;
  SetProductionCount({required ProductsRepository productsRepository})
    : _productsRepository = productsRepository;

  Future call(String compositionId, String newCount) async {
    return await _productsRepository.setProductCount(compositionId, newCount);
  }
}
