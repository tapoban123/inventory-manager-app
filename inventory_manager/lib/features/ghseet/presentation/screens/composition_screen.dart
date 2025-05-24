import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_manager/features/ghseet/presentation/components/composition_card.dart';

class CompositionScreen extends StatelessWidget {
  const CompositionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CompositionCard(
          compositionTitle: "Pencil",
          materials: {},
          onDeleteCallback: () {},
          onSaveCallback: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
