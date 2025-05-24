import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompositionCard extends StatelessWidget {
  final String compositionTitle;
  final Map<String, String> materials;
  final VoidCallback onSaveCallback;
  final VoidCallback onDeleteCallback;

  const CompositionCard({
    super.key,
    required this.compositionTitle,
    required this.materials,
    required this.onDeleteCallback,
    required this.onSaveCallback,
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
          children: List.generate(20, (index) {
            final materialName = materials.keys.toList();
            final materialAmount = materials.values.toList();

            return Text("$materialName x$materialAmount");
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
                                onTap: () {},
                                child: Icon(CupertinoIcons.minus, size: 18),
                              ),
                              SizedBox(
                                width: 80,
                                child: TextField(
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
                                ),
                              ),
                              InkWell(
                                onTap: () {},
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
              ElevatedButton(onPressed: onSaveCallback, child: Text("Save")),
            ],
          ),
    );
  }
}
