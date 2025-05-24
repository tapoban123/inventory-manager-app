import 'package:equatable/equatable.dart';

sealed class InventoryEvents extends Equatable {}

class AddToInventoryEvent extends InventoryEvents {
  final Map<String, int> newItem;

  AddToInventoryEvent({required this.newItem});

  @override
  List<Object?> get props => [newItem];
}

class RemoveFromInventoryEvent extends InventoryEvents {
  final String item;

  RemoveFromInventoryEvent({required this.item});

  @override
  List<Object?> get props => [item];
}

class FetchFromInventoryEvent extends InventoryEvents {
  @override
  List<Object?> get props => [];
}

class UpdateInventoryEvent extends InventoryEvents {
  final List<int> newQuantities;

  UpdateInventoryEvent({required this.newQuantities});
  @override
  List<Object?> get props => [newQuantities];
}
