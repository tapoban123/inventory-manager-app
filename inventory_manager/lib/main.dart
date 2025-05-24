import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/core/gsheet_config.dart';
import 'package:inventory_manager/features/home/presentation/bloc/bottom_navigation_cubit.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:inventory_manager/features/home/presentation/screens/home_screen.dart';
import 'package:inventory_manager/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await gSheetInitialise();
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavigationCubit()),
        BlocProvider(create: (context) => getIt<InventoryBloc>()),
        BlocProvider(create: (context) => getIt<CompositionBloc>()),
      ],
      child: MaterialApp(
        title: 'Inventory Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
