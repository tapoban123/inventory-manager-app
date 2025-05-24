import 'package:inventory_manager/core/gsheet_config.dart';
import 'package:inventory_manager/features/home/data/datasources/composition_sheet_datasource.dart';

class CompositionSheetDatasourceImpl extends CompositionSheetDatasource {
  @override
  Future<bool?> createNewComposition(Map<String, String> newComposition) async {
    final response = compositionGsheet?.values.map.appendRow(newComposition);
    return response;
  }

  @override
  Future<List<Map<String, String>>?> fetchAllComposition() async {
    final allCompositions = await compositionGsheet?.values.map.allRows();
    return allCompositions;
  }

  @override
  Future<bool?> removeComposition(String compositionId) async {
    final index = await compositionGsheet?.values.rowIndexOf(compositionId);
    final response = compositionGsheet?.deleteRow(index!);
    return response;
  }

  @override
  Future<Map<String, String>?> fetchSpecificComposition(
    String compositionId,
  ) async {
    final index = await compositionGsheet?.values.rowIndexOf(compositionId);
    final composition = await compositionGsheet?.values.map.row(index!);
    return composition;
  }

  @override
  Future<bool?> updateAvailableMaterials(List<String> newMaterialColumn) async {
    final response = await compositionGsheet?.values.appendColumn(
      newMaterialColumn,
    );
    return response;
  }

  @override
  Future<bool?> updateComposition(List<List<String>> updatedComposition) async {
    final response = await compositionGsheet?.values.insertRows(
      2,
      updatedComposition,
    );

    return response;
  }
}
