import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// (ده "العقل" بتاع الثيم)
class ThemeCubit extends Cubit<ThemeMode> {
  // (ده المفتاح اللي هنخزن بيه في الـ SharedPreferences)
  static const String _themeModeKey = 'theme_mode';

  ThemeCubit() : super(ThemeMode.system) {
    // (أول ما الـ Cubit يشتغل، حاول "تحمل" الثيم القديم)
    _loadThemeMode();
  }

  // (دالة "التحميل")
  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    // (بنقرأ الـ String اللي خزنّاه)
    final themeString = prefs.getString(_themeModeKey);

    ThemeMode themeMode = ThemeMode.system; // (الافتراضي)

    if (themeString == 'light') {
      themeMode = ThemeMode.light;
    } else if (themeString == 'dark') {
      themeMode = ThemeMode.dark;
    }

    // (بنبعت الثيم اللي لقيناه للـ UI)
    emit(themeMode);
  }

  // (دالة "التغيير" اللي شاشة الإعدادات هتنادي عليها)
  Future<void> changeTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();

    String themeString;
    if (themeMode == ThemeMode.light) {
      themeString = 'light';
    } else if (themeMode == ThemeMode.dark) {
      themeString = 'dark';
    } else {
      themeString = 'system';
    }

    // (بنخزن الـ String)
    await prefs.setString(_themeModeKey, themeString);

    // (بنبعت الثيم الجديد للـ UI)
    emit(themeMode);
  }
}
