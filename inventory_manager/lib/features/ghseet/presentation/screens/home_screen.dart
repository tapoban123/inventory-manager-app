import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.center_focus_weak_rounded),
            label: "Composition",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_rounded),
            label: "Inventory",
          ),
        ],
      ),
    );
  }
}
