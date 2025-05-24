import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/core/utils/utils.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_events.dart';

class CompositionCard extends StatelessWidget {
  final String compositionId;
  final String product;
  final String count;
  final String compositionTitle;
  final Map<String, String> materials;
  final VoidCallback onDeleteCallback;

  const CompositionCard({
    super.key,
    required this.product,
    required this.compositionId,
    required this.count,
    required this.compositionTitle,
    required this.materials,
    required this.onDeleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              compositionTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    showEditCompositionDialog(context);
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: onDeleteCallback,
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
        subtitle: Wrap(
          spacing: 10,
          children: List.generate(materials.length, (index) {
            final materialName = materials.keys.toList();
            final materialAmount = materials.values.toList();

            return Text("${materialName[index]} x${materialAmount[index]}");
          }),
        ),
      ),
    );
  }

  void showEditCompositionDialog(BuildContext context) {
    final List<TextEditingController> materialControllers = [];

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            scrollable: true,
            title: Text(compositionTitle),
            content: SizedBox(
              height: 350,
              width: 250,
              child: ListView.builder(
                itemCount: materials.keys.length,
                itemBuilder: (context, index) {
                  if (materialControllers.isEmpty) {
                    for (int i = 0; i < materials.keys.length; i++) {
                      materialControllers.add(
                        TextEditingController(
                          text: materials.values.toList()[i],
                        ),
                      );
                    }
                  }

                  ValueNotifier<TextEditingController> controller =
                      ValueNotifier(materialControllers[index]);

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(materials.keys.toList()[index]),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (int.parse(controller.value.text) > 0) {
                                    controller.value.text =
                                        (int.parse(controller.value.text) - 1)
                                            .toString();
                                  }
                                },
                                child: Icon(CupertinoIcons.minus, size: 18),
                              ),
                              ValueListenableBuilder(
                                valueListenable: controller,
                                builder:
                                    (context, controllerValue, child) =>
                                        SizedBox(
                                          width: 80,
                                          child: TextField(
                                            controller: controllerValue,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                            textAlign: TextAlign.center,
                                            onTapOutside: (event) {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            style: TextStyle(fontSize: 12),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.value.text =
                                      (int.parse(controller.value.text) + 1)
                                          .toString();
                                },
                                child: Icon(CupertinoIcons.add, size: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  final updatedComposition = [compositionId, product, count];
                  for (final controller in materialControllers) {
                    updatedComposition.add(controller.text);
                  }

                  context.read<CompositionBloc>().add(
                    UpdateCompositionEvent(
                      updatedComposition: updatedComposition,
                    ),
                  );
                  Navigator.of(context).pop();
                  showToastMessage("Updated composition.");
                },
                child: Text("Save"),
              ),
            ],
          ),
    );
  }
}
