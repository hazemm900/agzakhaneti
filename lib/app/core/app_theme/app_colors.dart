// (1) دي الألوان الخام اللي هنستخدمها في التطبيق
// بنفصلها في كلاس لوحدها عشان نقدر نستخدمها في أي مكان بسهولة
import 'package:flutter/material.dart';

class AppColors {
  // --- الألوان الأساسية (Primary Palette) ---
  // (درجات الأزرق المريح)
  static const Color primaryBlue = Color(0xFF3B82F6); // لون أزرق واضح ومريح
  static const Color primaryBlueLight = Color(0xFF93C5FD); // درجة أفتح
  static const Color primaryBlueDark = Color(0xFF2563EB); // درجة أغمق

  // --- الألوان الثانوية (Accent/Success Palette) ---
  // (درجات الأخضر)
  static const Color secondaryGreen = Color(0xFF10B981); // لون أخضر للنجاح
  static const Color secondaryGreenLight = Color(0xFF6EE7B7);
  static const Color secondaryGreenDark = Color(0xFF059669);

  // --- ألوان الخلفيات (Backgrounds) ---
  // (للوضع الفاتح)
  static const Color lightBg = Color(0xFFF9FAFB); // أوف-وايت خفيف
  static const Color lightCard = Color(0xFFFFFFFF); // أبيض ناصع للكروت
  // (للوضع الغامق)
  static const Color darkBg = Color(0xFF111827); // كحلي غامق جداً
  static const Color darkCard = Color(
    0xFF1F2937,
  ); // رمادي غامق (أفتح من الخلفية)

  // --- ألوان النصوص (Text) ---
  static const Color lightText = Color(0xFF1F2937); // أسود (مش غامق أوي)
  static const Color darkText = Color(0xFFF9FAFB); // أبيض (مش ناصع أوي)
  static const Color textSecondary = Color(0xFF6B7280); // رمادي للنصوص الثانوية

  // --- ألوان مساعدة (Utility) ---
  static const Color errorRed = Color(0xFFEF4444); // أحمر للخطأ
  static const Color warningYellow = Color(0xFFF59E0B); // أصفر للتنبيه
}
