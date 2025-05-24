import 'package:inventory_manager/features/home/domain/repository/composition_repository.dart';

class FetchSpecificComposition {
  final CompositionRepository _compositionRepository;
  FetchSpecificComposition({
    required CompositionRepository compositionRepository,
  }) : _compositionRepository = compositionRepository;

  Future<Map<String, String>?> call(String compositionId) async {
    return _compositionRepository.fetchSpecificComposition(compositionId);
  }
}
