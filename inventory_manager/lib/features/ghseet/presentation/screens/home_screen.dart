import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/features/ghseet/presentation/bloc/bottom_navigation_cubit.dart';
import 'package:inventory_manager/features/ghseet/presentation/components/home_bottom_nav_bar.dart';
import 'package:inventory_manager/features/ghseet/presentation/screens/composition_screen.dart';
import 'package:inventory_manager/features/ghseet/presentation/screens/inventory_screen.dart';
import 'package:inventory_manager/features/ghseet/presentation/screens/products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> appbarTitles = ["Products", "Compositions", "Inventory"];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, int>(
      builder:
          (context, state) => Scaffold(
            appBar: AppBar(
              title: Text(appbarTitles[state]),
              centerTitle: true,
              actions: [
                TextButton(onPressed: () {}, child: Text("Sync")),
                TextButton(onPressed: () {}, child: Text("Save")),
              ],
            ),
            bottomNavigationBar: HomeBottomNavBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (state == 0) {
                  print("Products");
                } else if (state == 1) {
                  print("Composition");
                } else if (state == 2) {
                  print("Inventory");
                }
              },
              child: Icon(Icons.add),
            ),
            body: IndexedStack(
              index: state,
              children: [
                ProductsScreen(),
                CompositionScreen(),
                InventoryScreen(),
              ],
            ),
          ),
    );
  }
}
