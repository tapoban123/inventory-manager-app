import 'package:hive_flutter/adapters.dart';
import 'package:inventory_manager/core/utils/utils.dart';

enum ThemesOptions {
  light("light"),
  dark("dark");

  final String name;

  const ThemesOptions(this.name);
}

class ThemesToggle {
  late Box _themeBox;

  Future<void> _init() async {
    _themeBox = await Hive.openBox(HiveBoxName.themeBox.name);
  }

  void setTheme(ThemesOptions theme) async {
    await _init();
    await _themeBox.put(HiveKeys.themeKey.name, theme.name);
    await _themeBox.close();
  }

  Future<String?> getTheme() async {
    await _init();
    final theme = await _themeBox.get(HiveKeys.themeKey.name);
    _themeBox.close();

    return theme;
  }
}
