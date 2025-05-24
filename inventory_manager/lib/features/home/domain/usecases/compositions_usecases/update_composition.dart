import 'package:inventory_manager/features/home/domain/repository/composition_repository.dart';

class UpdateComposition {
  final CompositionRepository _compositionRepository;

  UpdateComposition({required CompositionRepository compositionRepository})
    : _compositionRepository = compositionRepository;

  Future<bool?> call(List<List<String>> updatedComposition) async {
    return _compositionRepository.updateComposition(updatedComposition);
  }
}
