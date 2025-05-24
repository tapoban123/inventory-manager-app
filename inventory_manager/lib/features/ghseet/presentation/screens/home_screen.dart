import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/features/ghseet/presentation/bloc/bottom_navigation_cubit.dart';
import 'package:inventory_manager/features/ghseet/presentation/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:inventory_manager/features/ghseet/presentation/bloc/inventory_bloc/inventory_events.dart';
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
                TextButton(
                  onPressed: () {
                    if (state == 0) {
                    } else if (state == 1) {
                    } else if (state == 2) {
                      context.read<InventoryBloc>().add(
                        FetchFromInventoryEvent(),
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh, color: Colors.black),
                      SizedBox(width: 5),
                      Text("Sync", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: HomeBottomNavBar(),

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
