import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/core/utils/utils.dart';
import 'package:inventory_manager/features/ghseet/presentation/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:inventory_manager/features/ghseet/presentation/bloc/inventory_bloc/inventory_events.dart';
import 'package:inventory_manager/features/ghseet/presentation/bloc/inventory_bloc/inventory_state.dart';
import 'package:inventory_manager/features/ghseet/presentation/components/bottom_buttons.dart';
import 'package:inventory_manager/features/ghseet/presentation/components/item_card.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  TextEditingController newMaterialController = TextEditingController();
  TextEditingController newMaterialQuantityController = TextEditingController();

  final List<TextEditingController> materialControllers = [];

  @override
  void initState() {
    context.read<InventoryBloc>().add(FetchFromInventoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryBloc, InventoryStates>(
      builder: (context, state) {
        if (state.loadingStatus == InventoryLoadingStatus.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.loadingStatus == InventoryLoadingStatus.success) {
          final data = state.inventoryData?[0] as Map<String, String>;
          if (materialControllers.isEmpty) {
            for (int i = 0; i < data.keys.length; i++) {
              materialControllers.add(
                TextEditingController(text: data.values.toList()[i]),
              );
            }
          }
          return Column(
            children: [
              Expanded(
                flex: 10,
                child: ListView.builder(
                  itemCount: data.keys.length,
                  itemBuilder: (context, index) {
                    return ItemCard(
                      amountController: materialControllers[index],
                      title: data.keys.toList()[index],
                      removeItem: () {
                        materialControllers.removeAt(index);
                        context.read<InventoryBloc>().add(
                          RemoveFromInventoryEvent(
                            item: data.keys.toList()[index],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: BottomButtons(
                  addNewButtonTitle: "Add New Material",
                  onSaveCallback: () {
                    List<int> updatedValues = [];
                    for (int i = 0; i < data.keys.length; i++) {
                      updatedValues.add(int.parse(materialControllers[i].text));
                    }
                    context.read<InventoryBloc>().add(
                      UpdateInventoryEvent(newQuantities: updatedValues),
                    );

                    showToastMessage("Material Quantities Updated.");
                  },
                  addNewCallback: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            content: SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: TextField(
                                      controller: newMaterialController,
                                      decoration: InputDecoration(
                                        hintText: "Material",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: TextField(
                                      controller: newMaterialQuantityController,
                                      decoration: InputDecoration(
                                        hintText: "Quantity",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Map<String, int> items = data.map(
                                    (key, value) =>
                                        MapEntry(key, int.parse(value)),
                                  );
                                  items[newMaterialController.text] =
                                      newMaterialQuantityController.text.isEmpty
                                          ? 0
                                          : int.parse(
                                            newMaterialQuantityController.text,
                                          );
                                  context.read<InventoryBloc>().add(
                                    AddToInventoryEvent(newItem: items),
                                  );
                                  Navigator.of(context).pop();
                                  materialControllers.add(
                                    TextEditingController(
                                      text:
                                          items[newMaterialController.text]
                                              .toString(),
                                    ),
                                  );
                                  newMaterialController.clear();
                                  newMaterialQuantityController.clear();
                                  showToastMessage(
                                    "New Material added to Inventory.",
                                  );
                                },
                                child: Text(
                                  "Save",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
