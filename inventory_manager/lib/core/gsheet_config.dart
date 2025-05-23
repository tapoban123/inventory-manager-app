import 'dart:convert';

import 'package:gsheets/gsheets.dart';
import 'package:inventory_manager/gsheet_setup.dart'
    show compositionSheetId, credentials, inventorySheetId;

final gSheetInit = GSheets(jsonEncode(credentials));

Spreadsheet? compositionGsheetController;
Spreadsheet? inventoryGsheetController;

Worksheet? compositionGsheet;
Worksheet? inventoryGsheet;

Future<void> gSheetInitialise() async {
  compositionGsheetController = await gSheetInit.spreadsheet(
    compositionSheetId,
  );
  inventoryGsheetController = await gSheetInit.spreadsheet(inventorySheetId);

  compositionGsheet = compositionGsheetController?.worksheetByTitle(
    "composition_sheet",
  );
  inventoryGsheet = inventoryGsheetController?.worksheetByTitle(
    "inventory_sheet",
  );
}
