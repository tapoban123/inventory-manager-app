abstract class CompositionSheetDatasource {
  Future<void> createComposition();
  Future<void> removeComposition();
  Future<void> fetchComposition();
  Future<void> fetchAllComposition();
}
