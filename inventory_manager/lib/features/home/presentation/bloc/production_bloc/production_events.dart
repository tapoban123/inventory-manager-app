import 'package:equatable/equatable.dart';

sealed class ProductionEvents extends Equatable {}

class FetchAllProductsEvent extends ProductionEvents {
  @override
  List<Object?> get props => [];
}

class IncreaseProductionCountEvent extends ProductionEvents {
  final String compositionId;
  final String newCount;
  final int countIncreased;
  final Map<String, String> materials;

  IncreaseProductionCountEvent({
    required this.compositionId,
    required this.newCount,
    required this.materials,
    required this.countIncreased,
  });

  @override
  List<Object?> get props => [
    compositionId,
    newCount,
    countIncreased,
    materials,
  ];
}

class DecreaseProductionCountEvent extends ProductionEvents {
  final String compositionId;
  final String newCount;
  final int countDecreased;
  final Map<String, String> materials;

  DecreaseProductionCountEvent({
    required this.compositionId,
    required this.newCount,
    required this.countDecreased,
    required this.materials,
  });

  @override
  List<Object?> get props => [
    compositionId,
    newCount,
    countDecreased,
    materials,
  ];
}
