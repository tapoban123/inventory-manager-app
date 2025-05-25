import 'package:equatable/equatable.dart';

sealed class CompositionEvents extends Equatable {}

class AddNewCompositionEvent extends CompositionEvents {
  final Map<String, String> newComposition;
  AddNewCompositionEvent({required this.newComposition});

  @override
  List<Object?> get props => [newComposition];
}

class FetchAllCompositionsEvent extends CompositionEvents {
  @override
  List<Object?> get props => [];
}

class FetchSpecificCompositionEvent extends CompositionEvents {
  final String compositionId;
  FetchSpecificCompositionEvent({required this.compositionId});

  @override
  List<Object?> get props => [compositionId];
}

class RemoveCompositionEvent extends CompositionEvents {
  final String compositionId;
  RemoveCompositionEvent({required this.compositionId});

  @override
  List<Object?> get props => [compositionId];
}

class AddNewCompositionMaterialEvent extends CompositionEvents {
  final List<String> newMaterialColumn;
  AddNewCompositionMaterialEvent({required this.newMaterialColumn});

  @override
  List<Object?> get props => [newMaterialColumn];
}

class RemoveCompositionMaterialEvent extends CompositionEvents {
  final String material;
  RemoveCompositionMaterialEvent({required this.material});

  @override
  List<Object?> get props => [material];
}

class UpdateCompositionEvent extends CompositionEvents {
  final List<String> updatedComposition;
  UpdateCompositionEvent({required this.updatedComposition});

  @override
  List<Object?> get props => [updatedComposition];
}
