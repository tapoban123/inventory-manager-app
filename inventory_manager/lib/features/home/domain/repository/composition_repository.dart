abstract class CompositionRepository {
  Future<bool?> createNewComposition(Map<String, String> newComposition);
  Future<List<Map<String, String>>?> fetchAllComposition();
  Future<bool?> removeComposition(String compositionId);
  Future<Map<String, String>?> fetchSpecificComposition(String compositionId);
  Future<bool?> updateComposition(List<String> updatedComposition);
  Future<bool?> addCompositionMaterial(List<String> newMaterialColumn);
  Future<bool?> removeCompositionMaterial(String material);
}
