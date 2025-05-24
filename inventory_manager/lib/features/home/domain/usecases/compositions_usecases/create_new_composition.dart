import 'package:inventory_manager/features/home/domain/repository/composition_repository.dart';

class CreateNewComposition {
  final CompositionRepository _compositionRepository;
  CreateNewComposition({required CompositionRepository compositionRepository})
    : _compositionRepository = compositionRepository;

  Future<bool?> call(Map<String, String> newComposition) async {
    return _compositionRepository.createNewComposition(newComposition);
  }
}
