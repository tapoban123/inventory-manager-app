import 'package:flutter/material.dart';
import 'package:inventory_manager/features/ghseet/presentation/components/item_card.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemCard(
          amountController: TextEditingController(text: "0"),
          title: "Wood",
        ),
      ],
    );
  }
}
