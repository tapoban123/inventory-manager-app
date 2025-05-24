import 'package:equatable/equatable.dart';

enum ProductsLoadingStatus {
  initial,
  loading,
  increasingCount,
  decreasingCount,
  increaseDone,
  decreaseDone,
  success,
  error,
}

class ProductsStates extends Equatable {
  final ProductsLoadingStatus loadingStatus;
  final List<Map<String, String>>? productsData;
  final String? error;

  const ProductsStates({
    this.loadingStatus = ProductsLoadingStatus.initial,
    this.productsData,
    this.error,
  });

  ProductsStates copyWith({
    ProductsLoadingStatus? loadingStatus,
    List<Map<String, String>>? productsData,
    String? error,
  }) {
    return ProductsStates(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      productsData: productsData ?? this.productsData,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [loadingStatus, productsData, error];
}
