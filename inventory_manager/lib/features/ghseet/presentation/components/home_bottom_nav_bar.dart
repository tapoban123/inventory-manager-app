import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/features/ghseet/presentation/bloc/bottom_navigation_cubit.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BlocBuilder<BottomNavigationCubit, int>(
        builder:(context, state) =>  BottomNavigationBar(
          selectedItemColor: Colors.black,
          selectedFontSize: 15,
          unselectedItemColor: Colors.grey.shade500,
          currentIndex: state,
          onTap: (page) {
            context.read<BottomNavigationCubit>().changePage(page);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Products"),
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
