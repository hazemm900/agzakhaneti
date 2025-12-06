// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'أجزخانتي';

  @override
  String get myMedications => 'أدويتي';

  @override
  String get mySchedule => 'جدولي';

  @override
  String get healthLog => 'السجل الصحي';

  @override
  String get settings => 'الإعدادات';

  @override
  String get close => 'إغلاق';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get requiredField => 'الحقل المطلوب';

  @override
  String get errorOccurred => 'حدث خطأ:';

  @override
  String get unknownState => 'حالة غير معروفة';

  @override
  String get addMedication => 'إضافة دواء';

  @override
  String get addNewMedication => 'إضافة دواء جديد';

  @override
  String get noMedications => 'لا توجد أدوية. اضغط + للإضافة.';

  @override
  String get noMedicationsList =>
      'لا يوجد أدوية حالياً. اضغط + لإضافة أول دواء.';

  @override
  String get editMedication => 'تعديل الدواء';

  @override
  String get deleteMedication => 'حذف الدواء';

  @override
  String get medicineName => 'اسم الدواء';

  @override
  String get medicineShape => 'شكل الدواء';

  @override
  String get chooseMedicineShape => 'اختر شكل الدواء...';

  @override
  String get doseAmountWith => 'كمية الجرعة بـ';

  @override
  String get currentStockWith => 'المخزون الحالي بـ';

  @override
  String get alertMeWhenStockComesTo => 'نبهني عندما يصل المخزون إلى ';

  @override
  String get notes => 'ملاحظات (اختياري)';

  @override
  String get example => 'مثال: قبل الأكل، على معدة فارغة...';

  @override
  String get saveEdits => 'حفظ التعديلات';

  @override
  String get saveMedicine => 'حفظ الدواء';

  @override
  String get currentStock => 'المخزون الحالي';

  @override
  String get dose => 'الجرعة';

  @override
  String get takeDose => 'تسجيل أخذ الجرعة';

  @override
  String get confirmDose => 'تأكيد الجرعة';

  @override
  String tookDoseQuestion(Object amount, Object medicine) {
    return 'هل أخذت جرعة \"$medicine\" الآن؟\nسيتم خصم $amount من المخزون.';
  }

  @override
  String doseTakenSuccess(Object medicine) {
    return 'تم خصم جرعة $medicine بنجاح.';
  }

  @override
  String get capsule => 'قرص';

  @override
  String get mM => 'مللي';

  @override
  String get unit => 'وحدة';

  @override
  String get puff => 'بخة';

  @override
  String get drop => 'نقطة';

  @override
  String get use => 'استخدام';

  @override
  String get addNewSchedule => 'إضافة ميعاد جديد';

  @override
  String get editSchedule => 'تعديل الميعاد';

  @override
  String get scheduleName => 'اسم الميعاد';

  @override
  String get scheduleNameHint => 'مثال: جرعة الصباح';

  @override
  String get pickTimeLabel => 'اختيار الوقت:';

  @override
  String get pickTimeHint => 'اضغط لاختيار الوقت';

  @override
  String get repeatDays => 'التكرار (الأيام):';

  @override
  String get chooseTimeError => 'الرجاء اختيار وقت للمنبه';

  @override
  String get chooseDayError => 'الرجاء اختيار يوم واحد على الأقل';

  @override
  String get saveChanges => 'حفظ التعديلات';

  @override
  String get saveSchedule => 'حفظ الميعاد';

  @override
  String get noLinkedMedications =>
      'لا يوجد أدوية مربوطة بهذا الميعاد حتى الآن.';

  @override
  String get unlinkMedicationTooltip => 'فك ربط الدواء من الميعاد';

  @override
  String get linkMedicationTooltip => 'ربط دواء بهذا الميعاد';

  @override
  String get noSchedulesFound =>
      'لا يوجد مواعيد مجدولة حالياً. اضغط + لإضافة أول ميعاد.';

  @override
  String get time => 'الساعة';

  @override
  String get editScheduleTooltip => 'تعديل الميعاد';

  @override
  String get deleteScheduleTooltip => 'حذف الميعاد';

  @override
  String get linkMedicationToSchedule => 'ربط دواء بالميعاد';

  @override
  String get allMedicationsLinked =>
      'رائع! كل الأدوية في مخزنك مربوطة بهذا الميعاد، أو أن المخزن فارغ.';

  @override
  String get linkThisMedication => 'ربط هذا الدواء';

  @override
  String get addNewReading => 'إضافة قراءة جديدة';

  @override
  String get editHealthReading => 'تعديل القراءة';

  @override
  String get chooseReadingType => 'اختر نوع القياس:';

  @override
  String get saveHealthReading => 'حفظ القراءة';

  @override
  String get saveHealthReadingEdits => 'حفظ التعديلات';

  @override
  String get systolicPressure => 'الضغط الانقباضي (العالي)';

  @override
  String get diastolicPressure => 'الضغط الانبساطي (الواطي)';

  @override
  String get bloodSugarLevel => 'مستوى السكر (mg/dL)';

  @override
  String get bloodSugarStatus => 'حالة القياس';

  @override
  String get chooseSugarStatusHint => 'اختر حالة القياس...';

  @override
  String get invalidNumber => 'رقم غير صحيح';

  @override
  String get chooseReadingTypeFirst => 'الرجاء اختيار نوع القياس أولاً';

  @override
  String get healthLogTitle => 'السجل الصحي';

  @override
  String get healthLogTabList => 'القائمة';

  @override
  String get healthLogTabReports => 'التقارير';

  @override
  String healthLogErrorOccurred(Object message) {
    return 'حدث خطأ: $message';
  }

  @override
  String get healthLogNoData =>
      'لا توجد بيانات لرسم التقارير. ابدأ بإضافة قراءات أولاً.';

  @override
  String get healthLogBloodPressureReport => 'تقرير ضغط الدم';

  @override
  String get healthLogBloodPressureNeedTwo =>
      '(محتاج قراءتين على الأقل لرسم التقرير)';

  @override
  String get healthLogBloodSugarReport => 'تقرير سكر الدم';

  @override
  String get healthLogBloodSugarNeedTwo =>
      '(محتاج قراءتين على الأقل لرسم التقرير)';

  @override
  String get healthLogUnknownState => 'حالة غير معروفة';

  @override
  String get healthLogNoReadings =>
      'لا توجد قراءات مسجلة. اضغط + لإضافة أول قراءة.';

  @override
  String get healthLogUnknownReading => 'قراءة غير معروفة';

  @override
  String get healthLogBloodPressureTitle => 'قياس ضغط الدم';

  @override
  String get healthLogBloodPressureLabel => 'الضغط';

  @override
  String get healthLogBloodSugarTitle => 'قياس سكر الدم';

  @override
  String get healthLogBloodSugarLabel => 'السكر';

  @override
  String get healthLogEditReading => 'تعديل القراءة';

  @override
  String get healthLogDeleteReading => 'حذف القراءة';

  @override
  String get bloodSugarFasting => 'صائم';

  @override
  String get bloodSugarPostMeal => 'بعد الأكل';

  @override
  String get bloodSugarRandom => 'عشوائي';

  @override
  String get settingsTheme => 'المظهر';

  @override
  String get settingsSystemTheme => 'وضع النظام';

  @override
  String get settingsFollowDevice => 'يتبع إعدادات الموبايل';

  @override
  String get settingsLightTheme => 'الوضع الفاتح';

  @override
  String get settingsDarkTheme => 'الوضع الغامق';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsSystemLanguage => 'لغة الجهاز';

  @override
  String get settingsArabic => 'العربية';

  @override
  String get settingsEnglish => 'English';

  @override
  String get settingsAbout => 'عن التطبيق';

  @override
  String get settingsAboutApp => 'عن أجزخانتي';

  @override
  String get settingsContactUs => 'تواصل معنا';

  @override
  String get notificationsLowStockTitle => 'الأدوية (نقص المخزون)';

  @override
  String get notificationsStockOk => 'مخزونك تمام!';

  @override
  String get notificationsNoLowStock => 'لا يوجد أدوية قربت تخلص.';

  @override
  String get notificationsCurrentStock => 'المخزون الحالي:';

  @override
  String get notificationsRefillReminder => 'حد التنبيه:';

  @override
  String get notificationsNoData => 'لا توجد بيانات';

  @override
  String get sat => 'سبت';

  @override
  String get sun => 'أحد';

  @override
  String get mon => 'اثنين';

  @override
  String get tue => 'ثلاثاء';

  @override
  String get wed => 'أربعاء';

  @override
  String get thu => 'خميس';

  @override
  String get fri => 'جمعة';

  @override
  String get formPill => 'قرص/كبسولة';

  @override
  String get formSyrup => 'شراب';

  @override
  String get formInjection => 'حقنة';

  @override
  String get formInhaler => 'بخاخ';

  @override
  String get formDrops => 'نقط';

  @override
  String get formCream => 'كريم/مرهم';

  @override
  String get formOther => 'آخر';

  @override
  String get unitOther => 'أخرى';

  @override
  String get helpScreenTitle => 'المساعدة والشرح';

  @override
  String get appTourSection => 'جولة في التطبيق';

  @override
  String get resetTourTitle => 'إعادة الجولة التعليمية';

  @override
  String get resetTourSubtitle =>
      'نسيت التطبيق بيشتغل إزاي؟ اضغط هنا لإعادة الشرح خطوة بخطوة.';

  @override
  String get resetTourSuccess =>
      'تم إعادة الضبط! ارجع للصفحة الرئيسية لتبدأ الجولة.';

  @override
  String get videoTutorialsSection => 'فيديوهات الشرح';

  @override
  String get videoAddMedicationTitle => '1. إضافة دواء ومتابعة المخزون';

  @override
  String get videoScheduleTitle => '2. ضبط المواعيد وربط الأدوية';

  @override
  String get videoHealthLogTitle => '3. السجل الصحي والتقارير';

  @override
  String get showcaseAddMedTitle => 'إضافة دواء';

  @override
  String get showcaseAddMedDesc => 'اضغط هنا لإضافة دواء جديد وتتبع مخزونه.';

  @override
  String get showcaseAddScheduleTitle => 'إضافة ميعاد';

  @override
  String get showcaseAddScheduleDesc =>
      'قم بجدولة مواعيد الجرعات (فطار، غداء، عشاء).';

  @override
  String get showcaseLinkMedTitle => 'ربط الدواء';

  @override
  String get showcaseLinkMedDesc =>
      'اضغط هنا لاختيار الأدوية التي يتم تناولها في هذا الميعاد.';

  @override
  String get settingsHelp => 'المساعدة والدعم';

  @override
  String get settingsAppTutorial => 'شرح استخدام التطبيق';
}
