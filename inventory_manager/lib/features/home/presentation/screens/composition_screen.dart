import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_events.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_states.dart';
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

          return ListView.builder(
            itemCount: compositionData.length,
            itemBuilder: (context, index) {
              final composition = compositionData[index];
              final Map<String, String> materials = {};

              // for (final item in composition.keys.toList()) {
              //   if (item != "composition_id" ||
              //       item != "product" ||
              //       item != "count") {
              //     materials[item] = composition[item]!;
              //   }
              // }

              return CompositionCard(
                compositionTitle: composition["product"]!,
                materials: materials,
                onDeleteCallback: () {},
                onSaveCallback: () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
