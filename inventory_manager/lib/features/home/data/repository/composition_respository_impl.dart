import 'dart:developer' show log;

import 'package:inventory_manager/features/home/data/datasources/composition_sheet_datasource.dart';
import 'package:inventory_manager/features/home/domain/repository/composition_repository.dart';

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
      log("Composition Creation Error: $e");
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
      log("Composition Fetch Error: $e");

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
      log("Specific Composition Fetch Error: $e");

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
      log("Composition Remove Error: $e");

      return null;
    }
  }

  @override
  Future<bool?> addCompositionMaterial(List<String> newMaterialColumn) async {
    try {
      final response = await _compositionSheetDatasource.addCompositionMaterial(
        newMaterialColumn,
      );
      return response;
    } catch (e) {
      log("Add Composition Material Error: $e");

      return null;
    }
  }

  @override
  Future<bool?> removeCompositionMaterial(String material) async {
    try {
      final response = await _compositionSheetDatasource
          .removeCompositionMaterial(material);
      return response;
    } catch (e) {
      log("Remove Composition Material Error: $e");

      return null;
    }
  }

  @override
  Future<bool?> updateComposition(List<String> updatedComposition) async {
    try {
      final response = await _compositionSheetDatasource.updateComposition(
        updatedComposition,
      );
      return response;
    } catch (e) {
      log("Update Composition Error: $e");

      return null;
    }
  }
}
