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

class UpdateAvailableMaterialsEvent extends CompositionEvents {
  final List<String> newMaterialColumn;
  UpdateAvailableMaterialsEvent({required this.newMaterialColumn});

  @override
  List<Object?> get props => [newMaterialColumn];
}

class UpdateCompositionEvent extends CompositionEvents {
  final List<List<String>> updatedComposition;
  UpdateCompositionEvent({required this.updatedComposition});

  @override
  List<Object?> get props => [updatedComposition];
}
