import 'package:equatable/equatable.dart';

enum CompositionLoadingStatus {
  initial,
  loading,
  fetchingSpecificComposition,
  specificCompositionFetched,
  success,
  failure,
}

class CompositionStates extends Equatable {
  final CompositionLoadingStatus loadingStatus;
  final List<Map<String, String>>? compositionData;
  final Map<String, String>? specificCompositionData;
  final String? error;

  const CompositionStates({
    this.loadingStatus = CompositionLoadingStatus.initial,
    this.compositionData,
    this.error,
    this.specificCompositionData,
  });

  CompositionStates copyWith({
    CompositionLoadingStatus? loadingStatus,
    List<Map<String, String>>? compositionData,
    Map<String, String>? specificCompositionData,
    String? error,
  }) {
    return CompositionStates(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      compositionData: compositionData ?? this.compositionData,
      specificCompositionData:
          specificCompositionData ?? this.specificCompositionData,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    loadingStatus,
    compositionData,
    specificCompositionData,
    error,
  ];
}
