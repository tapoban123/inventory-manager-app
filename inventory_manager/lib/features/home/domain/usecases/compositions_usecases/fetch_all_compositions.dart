import 'package:inventory_manager/features/home/domain/repository/composition_repository.dart';

class FetchAllCompositions {
  final CompositionRepository _compositionRepository;
  FetchAllCompositions({required CompositionRepository compositionRepository})
    : _compositionRepository = compositionRepository;

  Future<List<Map<String, String>>?> call() async {
    return _compositionRepository.fetchAllComposition();
  }
}
