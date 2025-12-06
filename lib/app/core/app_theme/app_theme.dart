import 'package:flutter/material.dart';
import 'app_colors.dart'; // الملف اللي لسه عاملينه

class AppTheme {
  // --- (1) الثيم الفاتح (Light Theme) ---
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // الألوان الأساسية
      primaryColor: AppColors.primaryBlue,
      scaffoldBackgroundColor: AppColors.lightBg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryBlue,
        secondary: AppColors.secondaryGreen,
        background: AppColors.lightBg,
        surface: AppColors.lightCard, // لون الكروت والـ AppBars
        error: AppColors.errorRed,
        onPrimary: Colors.white, // لون الكلام اللي فوق اللون الأساسي
        onSecondary: Colors.white,
        onBackground: AppColors.lightText,
        onSurface: AppColors.lightText,
        onError: Colors.white,
      ),

      // ثيم الـ AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightCard,
        elevation: 1,
        scrolledUnderElevation: 1,
        iconTheme: IconThemeData(color: AppColors.lightText),
        titleTextStyle: TextStyle(
          color: AppColors.lightText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // ثيم ال NavBar
      navigationBarTheme: NavigationBarThemeData(
        height: 70, // ارتفاع مريح
        elevation: 2,
        backgroundColor: Colors.white, // خلفية البار
        indicatorColor: AppColors.primaryBlue.withOpacity(0.15), // لون الكبسولة
        // ستايل النص (Label)
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.lightText,
          ),
        ),

        // ستايل الأيقونات (Selected vs Unselected)
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            // الأيقونة المختارة (لون أزرق)
            return const IconThemeData(color: AppColors.primaryBlue, size: 26);
          }
          // الأيقونة غير المختارة (رمادي)
          return IconThemeData(
            color: AppColors.lightText.withOpacity(0.6),
            size: 24,
          );
        }),
      ),

      // ثيم الكروت
      cardTheme: const CardThemeData(
        color: AppColors.lightCard,
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),

      // ثيم الزراير
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),

      // (ممكن نضيف ثيمات تانية زي الـ TextTheme هنا)
    );
  }

  // --- (2) الثيم الغامق (Dark Theme) ---
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // الألوان الأساسية
      primaryColor: AppColors.primaryBlueLight, // بنستخدم الأزرق الفاتح هنا
      scaffoldBackgroundColor: AppColors.darkBg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryBlueLight, // الأزرق الفاتح عشان يبان
        secondary: AppColors.secondaryGreenLight,
        background: AppColors.darkBg,
        surface: AppColors.darkCard, // لون الكروت والـ AppBars
        error: AppColors.errorRed,
        onPrimary: AppColors.darkBg, // لون الكلام اللي فوق اللون الأساسي
        onSecondary: AppColors.darkBg,
        onBackground: AppColors.darkText,
        onSurface: AppColors.darkText,
        onError: Colors.white,
      ),

      // ثيم الـ AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkCard,
        elevation: 1,
        scrolledUnderElevation: 1,
        iconTheme: IconThemeData(color: AppColors.darkText),
        titleTextStyle: TextStyle(
          color: AppColors.darkText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // ثيم ال NavBar
      navigationBarTheme: NavigationBarThemeData(
        height: 70,
        elevation: 2,
        backgroundColor: AppColors.darkBg, // لون مميز للبار في الدارك
        indicatorColor: AppColors.primaryBlueLight.withOpacity(
          0.2,
        ), // كبسولة زرقاء فاتحة

        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
          ),
        ),

        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(
              color: AppColors.primaryBlueLight,
              size: 26,
            );
          }
          return IconThemeData(
            color: AppColors.darkText.withOpacity(0.6),
            size: 24,
          );
        }),
      ),

      // ثيم الكروت
      cardTheme: const CardThemeData(
        color: AppColors.darkCard,
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),

      // ثيم الزراير
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlueLight,
          foregroundColor: AppColors.darkBg, // بنستخدم اللون الغامق للنص
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
