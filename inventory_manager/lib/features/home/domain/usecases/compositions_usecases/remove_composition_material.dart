import 'package:inventory_manager/features/home/domain/repository/composition_repository.dart';

class RemoveCompositionMaterial {
  final CompositionRepository _compositionRepository;
  RemoveCompositionMaterial({
    required CompositionRepository compositionRepository,
  }) : _compositionRepository = compositionRepository;

  Future<bool?> call(String material) async {
    return _compositionRepository.removeCompositionMaterial(material);
  }
}
