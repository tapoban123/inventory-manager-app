import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:inventory_manager/core/gsheet_config.dart';
import 'package:inventory_manager/core/theme/theme_cubit.dart';
import 'package:inventory_manager/core/theme/themes_toggle.dart';
import 'package:inventory_manager/features/home/presentation/bloc/bottom_navigation_cubit.dart';
import 'package:inventory_manager/features/home/presentation/bloc/composition_bloc/composition_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/notifications_cubit.dart';
import 'package:inventory_manager/features/home/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:inventory_manager/features/home/presentation/screens/home_screen.dart';
import 'package:inventory_manager/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await gSheetInitialise();

  init();
  final themeCubit = getIt<ThemeCubit>();
  final currentTheme = await themeCubit.getTheme();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavigationCubit()),
        BlocProvider(create: (context) => NotificationsCubit()),
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
        BlocProvider(create: (context) => getIt<InventoryBloc>()),
        BlocProvider(create: (context) => getIt<CompositionBloc>()),
        BlocProvider(create: (context) => getIt<ProductsBloc>()),
      ],
      child: MyApp(currentTheme: currentTheme),
    ),
  );
}

class MyApp extends StatefulWidget {
  final ThemesOptions currentTheme;
  const MyApp({super.key, required this.currentTheme});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<ThemeCubit>().setTheme(widget.currentTheme);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemesOptions?>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Inventory Manager',
          debugShowCheckedModeBanner: false,
          theme:
              state == ThemesOptions.dark
                  ? ThemeData.dark()
                  : ThemeData.light(),
          home: HomeScreen(),
        );
      },
    );
  }
}
