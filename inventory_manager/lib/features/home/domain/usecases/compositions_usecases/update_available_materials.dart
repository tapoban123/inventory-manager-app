import 'package:inventory_manager/features/home/domain/repository/composition_repository.dart';

class UpdateAvailableMaterials {
  final CompositionRepository _compositionRepository;
  UpdateAvailableMaterials({
    required CompositionRepository compositionRepository,
  }) : _compositionRepository = compositionRepository;

  Future<bool?> call(List<String> newMaterialColumn) async {
    return _compositionRepository.updateAvailableMaterials(newMaterialColumn);
  }
}
