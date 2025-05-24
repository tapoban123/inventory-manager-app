import 'package:inventory_manager/features/home/domain/repository/composition_repository.dart';

class AddCompositionMaterial {
  final CompositionRepository _compositionRepository;
  AddCompositionMaterial({
    required CompositionRepository compositionRepository,
  }) : _compositionRepository = compositionRepository;

  Future<bool?> call(List<String> newMaterialColumn) async {
    return _compositionRepository.addCompositionMaterial(newMaterialColumn);
  }
}
