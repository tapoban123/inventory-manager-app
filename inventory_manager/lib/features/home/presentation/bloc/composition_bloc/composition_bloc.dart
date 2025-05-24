import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/create_new_composition.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/fetch_all_compositions.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/fetch_specific_composition.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/remove_composition.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/update_available_materials.dart';
import 'package:inventory_manager/features/home/domain/usecases/compositions_usecases/update_composition.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_events.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_states.dart';

class CompositionBloc extends Bloc<CompositionEvents, CompositionStates> {
  final CreateNewComposition _createNewComposition;
  final FetchAllCompositions _fetchAllCompositions;
  final FetchSpecificComposition _fetchSpecificComposition;
  final RemoveComposition _removeComposition;
  final UpdateAvailableMaterials _updateAvailableMaterials;
  final UpdateComposition _updateComposition;

  CompositionBloc({
    required CreateNewComposition createNewComposition,
    required FetchAllCompositions fetchAllCompositions,
    required FetchSpecificComposition fetchSpecificComposition,
    required RemoveComposition removeComposition,
    required UpdateAvailableMaterials updateAvailableMaterials,
    required UpdateComposition updateComposition,
  }) : _createNewComposition = createNewComposition,
       _fetchAllCompositions = fetchAllCompositions,
       _fetchSpecificComposition = fetchSpecificComposition,
       _removeComposition = removeComposition,
       _updateAvailableMaterials = updateAvailableMaterials,
       _updateComposition = updateComposition,
       super(CompositionStates()) {
    on<AddNewCompositionEvent>(addNewComposition);
    on<FetchAllCompositionsEvent>(fetchAllCompositionsFromSheet);
    on<FetchSpecificCompositionEvent>(fetchSpecificCompositionFromSheet);
    on<RemoveCompositionEvent>(removeCompositionFromSheet);
    on<UpdateAvailableMaterialsEvent>(updateAvailableMaterialsOnSheet);
    on<UpdateCompositionEvent>(updateCompositionOnSheet);
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

  void updateAvailableMaterialsOnSheet(
    UpdateAvailableMaterialsEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(loadingStatus: CompositionLoadingStatus.loading));
    _updateAvailableMaterials.call(event.newMaterialColumn);
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

  void updateCompositionOnSheet(
    UpdateCompositionEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(loadingStatus: CompositionLoadingStatus.loading));
    _updateComposition.call(event.updatedComposition);

    final deepCopyData =
        state.compositionData?.map((e) => Map<String, int>.from(e)).toList();

    var values = [];
    for (int i = 0; i < event.updatedComposition.length; i++) {
      values = event.updatedComposition[i];

      for (int j = 0; j < values.length; j++) {
        deepCopyData?[i][deepCopyData[i].keys.toList()[j]] = values[j];
      }
    }

    print(deepCopyData);

    emit(state.copyWith(loadingStatus: CompositionLoadingStatus.success));
  }
}
