import 'package:inventory_manager/features/home/domain/repository/products_repository.dart';

class FetchAllProducts {
  final ProductsRepository _productsRepository;
  FetchAllProducts({required ProductsRepository productsRepository})
    : _productsRepository = productsRepository;

  Future call() async {
    return await _productsRepository.fetchAllProducts();
  }
}
