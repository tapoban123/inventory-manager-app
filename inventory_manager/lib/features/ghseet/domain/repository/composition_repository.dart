abstract class CompositionRepository {
  Future<bool?> createNewComposition();
  Future<void> removeComposition();
  Future<void> fetchAllCompositions();
  Future<void> fetchSpecificCompositions();
  Future<void> updateAvailableMaterials();
}
