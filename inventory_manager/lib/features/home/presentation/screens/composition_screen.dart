import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/core/utils/utils.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_events.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_states.dart';
import 'package:inventory_manager/features/home/presentation/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/inventory_bloc/inventory_events.dart';
import 'package:inventory_manager/features/home/presentation/bloc/inventory_bloc/inventory_state.dart';
import 'package:inventory_manager/features/home/presentation/components/composition_card.dart';

class CompositionScreen extends StatefulWidget {
  const CompositionScreen({super.key});

  @override
  State<CompositionScreen> createState() => _CompositionScreenState();
}

class _CompositionScreenState extends State<CompositionScreen> {
  @override
  void initState() {
    context.read<CompositionBloc>().add(FetchAllCompositionsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompositionBloc, CompositionStates>(
      builder: (context, state) {
        if (state.loadingStatus == CompositionLoadingStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.loadingStatus == CompositionLoadingStatus.success) {
          final compositionData = state.compositionData!;

          return Column(
            children: [
              Expanded(
                flex: 10,
                child: ListView.builder(
                  itemCount: compositionData.length,
                  itemBuilder: (context, index) {
                    final composition = compositionData[index];
                    final Map<String, String> materials = {};

                    for (final item in composition.keys.toList().sublist(3)) {
                      materials[item] = composition[item]!;
                    }

                    return CompositionCard(
                      compositionId: composition["composition_id"]!,
                      product: composition["product"]!,
                      count: composition["count"]!,
                      compositionTitle: composition["product"]!,
                      materials: materials,
                      onDeleteCallback: () {
                        context.read<CompositionBloc>().add(
                          RemoveCompositionEvent(
                            compositionId: composition["composition_id"]!,
                          ),
                        );

                        showToastMessage("Deleted composition");
                      },
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ).copyWith(bottom: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showCreateNewCompositionDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      "Add new Composition",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }

  void showCreateNewCompositionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: SizedBox(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Name",
                  enabledBorder: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(),
                ),
              ),
            ),

            content: _CreateNewCompositionMaterials(),
            actions: [ElevatedButton(onPressed: () {}, child: Text("Create"))],
          ),
    );
  }
}

class _CreateNewCompositionMaterials extends StatefulWidget {
  const _CreateNewCompositionMaterials();

  @override
  State<_CreateNewCompositionMaterials> createState() =>
      __CreateNewCompositionMaterialsState();
}

class __CreateNewCompositionMaterialsState
    extends State<_CreateNewCompositionMaterials> {
  @override
  void initState() {
    context.read<InventoryBloc>().add(FetchFromInventoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 250,
      child: BlocBuilder<InventoryBloc, InventoryStates>(
        builder: (context, state) {
          if (state.loadingStatus == InventoryLoadingStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.loadingStatus == InventoryLoadingStatus.success) {
            final inventoryMaterialNames =
                state.inventoryData![0].keys.toList();

            return ListView.builder(
              itemCount: inventoryMaterialNames.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(title: Text(inventoryMaterialNames[index])),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
