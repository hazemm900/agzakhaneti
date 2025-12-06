import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale?> {
  // (Locale? ممكن يكون null، ومعناه "لغة الجهاز")

  static const String _localeKey = 'app_locale';

  LocaleCubit() : super(null) {
    _loadLocale();
  }

  // تحميل اللغة المحفوظة
  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString(_localeKey);

    if (savedLang == 'ar') {
      emit(const Locale('ar'));
    } else if (savedLang == 'en') {
      emit(const Locale('en'));
    } else {
      emit(null); // لغة الجهاز (الافتراضي)
    }
  }

  // تغيير اللغة
  Future<void> changeLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();

    if (langCode == 'ar') {
      await prefs.setString(_localeKey, 'ar');
      emit(const Locale('ar'));
    } else if (langCode == 'en') {
      await prefs.setString(_localeKey, 'en');
      emit(const Locale('en'));
    } else {
      // لو "لغة الجهاز" (system)
      await prefs.remove(_localeKey); // بنمسح التفضيل عشان يرجع للأصل
      emit(null);
    }
  }
}
