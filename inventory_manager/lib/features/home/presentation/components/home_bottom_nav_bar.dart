import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/core/theme/theme_cubit.dart';
import 'package:inventory_manager/core/theme/themes_toggle.dart';
import 'package:inventory_manager/features/home/presentation/bloc/bottom_navigation_cubit.dart';
import 'package:inventory_manager/features/home/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/products_bloc/products_events.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<ThemeCubit>().state;

    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BlocBuilder<BottomNavigationCubit, int>(
        builder:
            (context, state) => BottomNavigationBar(
              backgroundColor:
                  currentTheme == ThemesOptions.dark
                      ? Colors.transparent
                      : Theme.of(context).scaffoldBackgroundColor,
              selectedItemColor:
                  currentTheme == ThemesOptions.dark
                      ? Colors.white
                      : Colors.black,
              selectedFontSize: 15,
              unselectedItemColor: Colors.grey.shade500,
              currentIndex: state,
              onTap: (page) {
                if (page == 0) {
                  context.read<ProductsBloc>().add(FetchAllProductsEvent());
                }
                context.read<BottomNavigationCubit>().changePage(page);
              },
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
      ),
    );
  }
}
