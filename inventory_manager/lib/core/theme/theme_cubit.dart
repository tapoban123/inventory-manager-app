import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/core/theme/themes_toggle.dart';

class ThemeCubit extends Cubit<ThemesOptions?> {
  final ThemesToggle _themesToggle;
  ThemeCubit({required ThemesToggle themesToggle})
    : _themesToggle = themesToggle,
      super(null);

  void setTheme(ThemesOptions theme) {
    _themesToggle.setTheme(theme);
    emit(theme);
  }

  Future<ThemesOptions> getTheme() async {
    final theme = await _themesToggle.getTheme();

    if (theme != null) {
      if (theme == ThemesOptions.dark.name) {
        emit(ThemesOptions.dark);
        return ThemesOptions.dark;
      } else {
        emit(ThemesOptions.light);
        return ThemesOptions.light;
      }
    } else {
      emit(ThemesOptions.light);
      return ThemesOptions.light;
    }
  }
}
