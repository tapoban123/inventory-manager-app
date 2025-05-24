import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/bottom_navigation_cubit.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_events.dart';
import 'package:inventory_manager/features/home/presentation/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/inventory_bloc/inventory_events.dart';
import 'package:inventory_manager/features/home/presentation/bloc/notifications_cubit.dart';
import 'package:inventory_manager/features/home/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/products_bloc/products_events.dart';
import 'package:inventory_manager/features/home/presentation/components/home_bottom_nav_bar.dart';
import 'package:inventory_manager/features/home/presentation/screens/composition_screen.dart';
import 'package:inventory_manager/features/home/presentation/screens/inventory_screen.dart';
import 'package:inventory_manager/features/home/presentation/screens/notifications_screen.dart';
import 'package:inventory_manager/features/home/presentation/screens/products_screen.dart';

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
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NotificationsScreen(),
                      ),
                    );
                  },
                  icon: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Icon(Icons.notifications, color: Colors.black),
                      BlocBuilder<NotificationsCubit, List<String>>(
                        builder: (context, state) {
                          if (state.isEmpty) {
                            return SizedBox.shrink();
                          }
                          return CircleAvatar(
                            radius: 6,
                            backgroundColor: Colors.red,
                            child: Text(
                              state.length.toString(),
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (state == 0) {
                      context.read<ProductsBloc>().add(FetchAllProductsEvent());
                    } else if (state == 1) {
                      context.read<CompositionBloc>().add(
                        FetchAllCompositionsEvent(),
                      );
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
