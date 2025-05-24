import 'package:inventory_manager/core/gsheet_config.dart';
import 'package:inventory_manager/features/ghseet/data/datasources/composition_sheet_datasource.dart';

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
    final response= compositionGsheet?.deleteRow(index!);
    return response;
  }

  @override
  Future<void> fetchSpecificComposition() {
    // TODO: implement fetchSpecificComposition
    throw UnimplementedError();
  }

  @override
  Future<void> updateAvailableMaterials() {
    // TODO: implement updateAvailableMaterials
    throw UnimplementedError();
  }
}
