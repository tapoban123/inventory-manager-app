import 'package:equatable/equatable.dart';

enum ProductionLoadingStatus {
  initial,
  loading,
  increasingCount,
  decreasingCount,
  increaseDone,
  decreaseDone,
  success,
  error,
}

class ProductionStates extends Equatable {
  final ProductionLoadingStatus loadingStatus;
  final List<Map<String, String>>? productionData;
  final String? error;

  const ProductionStates({
    this.loadingStatus = ProductionLoadingStatus.initial,
    this.productionData,
    this.error,
  });

  ProductionStates copyWith({
    ProductionLoadingStatus? loadingStatus,
    List<Map<String, String>>? productionData,
    String? error,
  }) {
    return ProductionStates(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      productionData: productionData ?? this.productionData,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [loadingStatus, productionData, error];
}
