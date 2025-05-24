import 'package:inventory_manager/features/home/domain/repository/composition_repository.dart';

class RemoveComposition {
  final CompositionRepository _compositionRepository;
  RemoveComposition({required CompositionRepository compositionRepository})
    : _compositionRepository = compositionRepository;

  Future<bool?> call(String compositionId) async {
    return _compositionRepository.removeComposition(compositionId);
  }
}
