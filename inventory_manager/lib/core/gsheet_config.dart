import 'dart:convert';

import 'package:gsheets/gsheets.dart';
import 'package:inventory_manager/gsheet_setup.dart' show credentials, sheetId;

final gSheetInit = GSheets(jsonEncode(credentials));

Spreadsheet? gSheetController;

Worksheet? gSheetUserDetails;

Future<void> gSheetInitialise() async {
  gSheetController = await gSheetInit.spreadsheet(sheetId);
  gSheetUserDetails = await gSheetController?.worksheetByTitle(
    "composition_sheet",
  );
}
