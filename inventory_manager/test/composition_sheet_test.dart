import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_manager/core/gsheet_config.dart';
import 'package:inventory_manager/features/home/data/datasources/composition/composition_sheet_datasource_impl.dart';

void main() {
  setUp(() async {
    await gSheetInitialise();
  });
  test("create new composition", () async {
    final compositionDatasource = CompositionSheetDatasourceImpl();

    final response = await compositionDatasource.createNewComposition({
      "product": "chair",
      "count": "2",
      "wood": "25",
    });
    print(response);
  });

  test("fetch all composition", () async {
    final compositionDatasource = CompositionSheetDatasourceImpl();

    final response = await compositionDatasource.fetchAllComposition();
    print(response);
  });
  test("delete composition", () async {
    final compositionDatasource = CompositionSheetDatasourceImpl();

    final response = await compositionDatasource.removeComposition("");
    print(response);
  });
  test("fetch specific composition", () async {
    final compositionDatasource = CompositionSheetDatasourceImpl();

    final response = await compositionDatasource.fetchSpecificComposition(
      "165",
    );
    print(response);
  });
  test("update available materials", () async {
    final compositionDatasource = CompositionSheetDatasourceImpl();

    final response = await compositionDatasource.updateAvailableMaterials([]);
    print(response);
  });
  test("update composition", () async {
    final compositionDatasource = CompositionSheetDatasourceImpl();

    final response = await compositionDatasource.updateComposition([
      "125",
      "soap",
      "78",
      "90",
      "56",
    ]);
    print(response);
  });
}
