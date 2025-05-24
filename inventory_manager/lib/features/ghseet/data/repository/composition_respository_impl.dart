import 'package:inventory_manager/features/ghseet/data/datasources/composition_sheet_datasource.dart';
import 'package:inventory_manager/features/ghseet/domain/repository/composition_repository.dart';

class CompositionRespositoryImpl extends CompositionRepository {
  final CompositionSheetDatasource _compositionSheetDatasource;
  CompositionRespositoryImpl({
    required CompositionSheetDatasource compositionSheetDatasource,
  }) : _compositionSheetDatasource = compositionSheetDatasource;

  @override
  Future<bool?> createNewComposition(Map<String, String> newComposition) async {
    try {
      final response = await _compositionSheetDatasource.createNewComposition(
        newComposition,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Map<String, String>>?> fetchAllComposition() async {
    try {
      final allCompositions =
          await _compositionSheetDatasource.fetchAllComposition();
      return allCompositions;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Map<String, String>?> fetchSpecificComposition(
    String compositionId,
  ) async {
    try {
      final composition = _compositionSheetDatasource.fetchSpecificComposition(
        compositionId,
      );
      return composition;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool?> removeComposition(String compositionId) async {
    try {
      final response = await _compositionSheetDatasource.removeComposition(
        compositionId,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool?> updateAvailableMaterials(List<String> newMaterialColumn) async {
    try {
      final response = await _compositionSheetDatasource
          .updateAvailableMaterials(newMaterialColumn);
      return response;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool?> updateComposition(List<List<String>> updatedComposition) async {
    try {
      final response = await _compositionSheetDatasource.updateComposition(
        updatedComposition,
      );
      return response;
    } catch (e) {
      return null;
    }
  }
}
