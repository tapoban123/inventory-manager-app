import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/create_new_composition.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/fetch_all_compositions.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/fetch_specific_composition.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/remove_composition.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/add_composition_material.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/remove_composition_material.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/update_composition.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_events.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_states.dart';

class CompositionBloc extends Bloc<CompositionEvents, CompositionStates> {
  final CreateNewComposition _createNewComposition;
  final FetchAllCompositions _fetchAllCompositions;
  final FetchSpecificComposition _fetchSpecificComposition;
  final RemoveComposition _removeComposition;
  final AddCompositionMaterial _addCompositionMaterial;
  final RemoveCompositionMaterial _removeCompositionMaterial;
  final UpdateComposition _updateComposition;

  CompositionBloc({
    required CreateNewComposition createNewComposition,
    required FetchAllCompositions fetchAllCompositions,
    required FetchSpecificComposition fetchSpecificComposition,
    required RemoveComposition removeComposition,
    required AddCompositionMaterial addCompositionMaterial,
    required RemoveCompositionMaterial removeCompositionMaterial,
    required UpdateComposition updateComposition,
  }) : _createNewComposition = createNewComposition,
       _fetchAllCompositions = fetchAllCompositions,
       _fetchSpecificComposition = fetchSpecificComposition,
       _removeComposition = removeComposition,
       _addCompositionMaterial = addCompositionMaterial,
       _updateComposition = updateComposition,
       _removeCompositionMaterial = removeCompositionMaterial,
       super(CompositionStates()) {
    on<AddNewCompositionEvent>(addNewComposition);
    on<FetchAllCompositionsEvent>(fetchAllCompositionsFromSheet);
    on<FetchSpecificCompositionEvent>(fetchSpecificCompositionFromSheet);
    on<RemoveCompositionEvent>(removeCompositionFromSheet);
    on<AddNewCompositionMaterialEvent>(addNewCompositionMaterial);
    on<UpdateCompositionEvent>(updateCompositionOnSheet);
    on<RemoveCompositionMaterialEvent>(removeCompositionMaterialFromSheet);
  }

  void addNewComposition(AddNewCompositionEvent event, Emitter emit) {
    _createNewComposition.call(event.newComposition);
    emit(
      state.copyWith(
        compositionData: [...state.compositionData!, event.newComposition],
      ),
    );
  }

  void fetchAllCompositionsFromSheet(
    FetchAllCompositionsEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(loadingStatus: CompositionLoadingStatus.loading));
    final data = await _fetchAllCompositions.call();
    emit(
      state.copyWith(
        loadingStatus: CompositionLoadingStatus.success,
        compositionData: data ?? [],
      ),
    );
  }

  void fetchSpecificCompositionFromSheet(
    FetchSpecificCompositionEvent event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        loadingStatus: CompositionLoadingStatus.fetchingSpecificComposition,
      ),
    );
    final composition = await _fetchSpecificComposition.call(
      event.compositionId,
    );
    emit(
      state.copyWith(
        loadingStatus: CompositionLoadingStatus.specificCompositionFetched,
        specificCompositionData: composition,
      ),
    );
  }

  void removeCompositionFromSheet(
    RemoveCompositionEvent event,
    Emitter emit,
  ) async {
    _removeComposition.call(event.compositionId);
    final deepCopyData =
        state.compositionData?.map((e) => Map<String, String>.from(e)).toList();

    deepCopyData?.remove(
      deepCopyData.firstWhere(
        (element) => element["composition_id"] == event.compositionId,
      ),
    );

    emit(state.copyWith(compositionData: deepCopyData));
  }

  void addNewCompositionMaterial(
    AddNewCompositionMaterialEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(loadingStatus: CompositionLoadingStatus.loading));
    _addCompositionMaterial.call(event.newMaterialColumn);
    final deepCopyData =
        state.compositionData?.map((e) => Map<String, String>.from(e)).toList();

    int index = 1;
    for (final composition in deepCopyData!) {
      composition[event.newMaterialColumn[0]] = event.newMaterialColumn[index];
      index++;
    }

    emit(
      state.copyWith(
        loadingStatus: CompositionLoadingStatus.success,
        compositionData: deepCopyData,
      ),
    );
  }

  void removeCompositionMaterialFromSheet(
    RemoveCompositionMaterialEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(loadingStatus: CompositionLoadingStatus.loading));
    _removeCompositionMaterial.call(event.material);
    final deepCopyData =
        state.compositionData?.map((e) => Map<String, String>.from(e)).toList();

    for (final composition in deepCopyData!) {
      composition.remove(event.material);
    }

    emit(
      state.copyWith(
        loadingStatus: CompositionLoadingStatus.success,
        compositionData: deepCopyData,
      ),
    );
  }

  void updateCompositionOnSheet(
    UpdateCompositionEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(loadingStatus: CompositionLoadingStatus.loading));
    _updateComposition.call(event.updatedComposition);

    final deepCopyData =
        state.compositionData?.map((e) => Map<String, String>.from(e)).toList();

    for (final composition in deepCopyData!) {
      if (composition["composition_id"] == event.updatedComposition[0]) {
        for (int i = 0; i < event.updatedComposition.length; i++) {
          composition[composition.keys.toList()[i]] =
              event.updatedComposition[i];
        }
      }
    }

    emit(
      state.copyWith(
        loadingStatus: CompositionLoadingStatus.success,
        compositionData: deepCopyData,
      ),
    );
  }
}
