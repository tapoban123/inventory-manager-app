import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

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
  final List<TextEditingController>? quantityControllers;
  final List<String>? notifications;
  FetchFromInventoryEvent({this.quantityControllers, this.notifications});
  @override
  List<Object?> get props => [quantityControllers, notifications];
}

class UpdateInventoryEvent extends InventoryEvents {
  final List<int> newQuantities;

  UpdateInventoryEvent({required this.newQuantities});
  @override
  List<Object?> get props => [newQuantities];
}
