abstract class CompositionSheetDatasource {
  Future<bool?> createNewComposition(Map<String, String> newComposition);
  Future<List<Map<String, String>>? > fetchAllComposition();
  Future<bool?> removeComposition(String compositionId);
  Future<void> fetchSpecificComposition();
  Future<void> updateAvailableMaterials();
}
