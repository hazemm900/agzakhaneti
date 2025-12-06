// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Agzakhaneti';

  @override
  String get myMedications => 'Medications';

  @override
  String get mySchedule => 'Schedule';

  @override
  String get healthLog => 'Health Log';

  @override
  String get settings => 'Settings';

  @override
  String get close => 'Close';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get requiredField => 'required field';

  @override
  String get errorOccurred => 'An error occurred:';

  @override
  String get unknownState => 'Unknown state';

  @override
  String get addMedication => 'Add Medication';

  @override
  String get addNewMedication => 'Add New Medication';

  @override
  String get noMedications => 'No medications found. Tap + to add.';

  @override
  String get noMedicationsList =>
      'No medications available. Tap + to add your first one.';

  @override
  String get editMedication => 'Edit Medicine';

  @override
  String get deleteMedication => 'Delete Medication';

  @override
  String get medicineName => 'Medicine Name';

  @override
  String get medicineShape => 'Medicine Form';

  @override
  String get chooseMedicineShape => 'Choose medicine form...';

  @override
  String get doseAmountWith => 'Dose amount in ';

  @override
  String get currentStockWith => 'Current stock in ';

  @override
  String get alertMeWhenStockComesTo => 'Alert me when stock reaches ';

  @override
  String get notes => 'Notes (optional)';

  @override
  String get example => 'Example: before eating, on an empty stomach...';

  @override
  String get saveEdits => 'Save Edits';

  @override
  String get saveMedicine => 'Save Medicine';

  @override
  String get currentStock => 'Current stock';

  @override
  String get dose => 'Dose';

  @override
  String get takeDose => 'Record dose taken';

  @override
  String get confirmDose => 'Confirm Dose';

  @override
  String tookDoseQuestion(Object amount, Object medicine) {
    return 'Did you take a dose of $medicine now?\n$amount will be deducted from stock.';
  }

  @override
  String doseTakenSuccess(Object medicine) {
    return 'Dose for $medicine has been deducted successfully.';
  }

  @override
  String get capsule => 'pill';

  @override
  String get mM => 'ml';

  @override
  String get unit => 'unit';

  @override
  String get puff => 'puff';

  @override
  String get drop => 'drop';

  @override
  String get use => 'application';

  @override
  String get addNewSchedule => 'Add New Schedule';

  @override
  String get editSchedule => 'Edit Schedule';

  @override
  String get scheduleName => 'Schedule Name';

  @override
  String get scheduleNameHint => 'Example: Morning dose';

  @override
  String get pickTimeLabel => 'Choose time:';

  @override
  String get pickTimeHint => 'Tap to choose time';

  @override
  String get repeatDays => 'Repeat (days):';

  @override
  String get chooseTimeError => 'Please choose a time';

  @override
  String get chooseDayError => 'Please choose at least one day';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get saveSchedule => 'Save schedule';

  @override
  String get noLinkedMedications =>
      'No medications linked to this schedule yet.';

  @override
  String get unlinkMedicationTooltip => 'Unlink medication from schedule';

  @override
  String get linkMedicationTooltip => 'Link medication to this schedule';

  @override
  String get noSchedulesFound =>
      'No schedules created yet. Tap + to add your first schedule.';

  @override
  String get time => 'Time';

  @override
  String get editScheduleTooltip => 'Edit schedule';

  @override
  String get deleteScheduleTooltip => 'Delete schedule';

  @override
  String get linkMedicationToSchedule => 'Link Medication to Schedule';

  @override
  String get allMedicationsLinked =>
      'Great! All medications are already linked to this schedule or the inventory is empty.';

  @override
  String get linkThisMedication => 'Link this medication';

  @override
  String get addNewReading => 'Add New Reading';

  @override
  String get editHealthReading => 'Edit Reading';

  @override
  String get chooseReadingType => 'Choose reading type:';

  @override
  String get saveHealthReading => 'Save Reading';

  @override
  String get saveHealthReadingEdits => 'Save Edits';

  @override
  String get systolicPressure => 'Systolic Pressure (High)';

  @override
  String get diastolicPressure => 'Diastolic Pressure (Low)';

  @override
  String get bloodSugarLevel => 'Blood Sugar Level (mg/dL)';

  @override
  String get bloodSugarStatus => 'Blood Sugar Status';

  @override
  String get chooseSugarStatusHint => 'Choose sugar status...';

  @override
  String get invalidNumber => 'Invalid number';

  @override
  String get chooseReadingTypeFirst => 'Please select a reading type first';

  @override
  String get healthLogTitle => 'Health Log';

  @override
  String get healthLogTabList => 'List';

  @override
  String get healthLogTabReports => 'Reports';

  @override
  String healthLogErrorOccurred(Object message) {
    return 'An error occurred: $message';
  }

  @override
  String get healthLogNoData =>
      'No data to plot reports. Start by adding readings first.';

  @override
  String get healthLogBloodPressureReport => 'Blood Pressure Report';

  @override
  String get healthLogBloodPressureNeedTwo =>
      '(Need at least two readings to plot report)';

  @override
  String get healthLogBloodSugarReport => 'Blood Sugar Report';

  @override
  String get healthLogBloodSugarNeedTwo =>
      '(Need at least two readings to plot report)';

  @override
  String get healthLogUnknownState => 'Unknown state';

  @override
  String get healthLogNoReadings =>
      'No readings recorded. Press + to add your first reading.';

  @override
  String get healthLogUnknownReading => 'Unknown reading';

  @override
  String get healthLogBloodPressureTitle => 'Blood Pressure Measurement';

  @override
  String get healthLogBloodPressureLabel => 'Pressure';

  @override
  String get healthLogBloodSugarTitle => 'Blood Sugar Measurement';

  @override
  String get healthLogBloodSugarLabel => 'Sugar';

  @override
  String get healthLogEditReading => 'Edit Reading';

  @override
  String get healthLogDeleteReading => 'Delete Reading';

  @override
  String get bloodSugarFasting => 'Fasting';

  @override
  String get bloodSugarPostMeal => 'Post Meal';

  @override
  String get bloodSugarRandom => 'Random';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsSystemTheme => 'System Theme';

  @override
  String get settingsFollowDevice => 'Follows device settings';

  @override
  String get settingsLightTheme => 'Light Theme';

  @override
  String get settingsDarkTheme => 'Dark Theme';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsSystemLanguage => 'System Language';

  @override
  String get settingsArabic => 'Arabic';

  @override
  String get settingsEnglish => 'English';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsAboutApp => 'About Agzakhaneti';

  @override
  String get settingsContactUs => 'Contact Us';

  @override
  String get notificationsLowStockTitle => 'Medications (Low Stock)';

  @override
  String get notificationsStockOk => 'Your stock is fine!';

  @override
  String get notificationsNoLowStock => 'No medications are about to run out.';

  @override
  String get notificationsCurrentStock => 'Current Stock:';

  @override
  String get notificationsRefillReminder => 'Refill Reminder:';

  @override
  String get notificationsNoData => 'No data available';

  @override
  String get sat => 'Sat';

  @override
  String get sun => 'Sun';

  @override
  String get mon => 'Mon';

  @override
  String get tue => 'Tue';

  @override
  String get wed => 'Wed';

  @override
  String get thu => 'Thu';

  @override
  String get fri => 'Fri';

  @override
  String get formPill => 'Pill/Capsule';

  @override
  String get formSyrup => 'Syrup';

  @override
  String get formInjection => 'Injection';

  @override
  String get formInhaler => 'Inhaler';

  @override
  String get formDrops => 'Drops';

  @override
  String get formCream => 'Cream/Ointment';

  @override
  String get formOther => 'Other';

  @override
  String get unitOther => 'Other';

  @override
  String get helpScreenTitle => 'Help & Tutorials';

  @override
  String get appTourSection => 'App Tour';

  @override
  String get resetTourTitle => 'Reset App Tour';

  @override
  String get resetTourSubtitle =>
      'Forgot how it works? Tap here to restart the walkthrough.';

  @override
  String get resetTourSuccess => 'Reset done! Return to Home Screen to start.';

  @override
  String get videoTutorialsSection => 'Video Tutorials';

  @override
  String get videoAddMedicationTitle => '1. Adding Medicine & Stock Tracking';

  @override
  String get videoScheduleTitle => '2. Setting Schedules & Linking';

  @override
  String get videoHealthLogTitle => '3. Health Log & Reports';

  @override
  String get showcaseAddMedTitle => 'Add Medicine';

  @override
  String get showcaseAddMedDesc =>
      'Tap here to add a new medicine and track its stock.';

  @override
  String get showcaseAddScheduleTitle => 'Add Schedule';

  @override
  String get showcaseAddScheduleDesc =>
      'Schedule your dose times (Breakfast, Lunch, Dinner).';

  @override
  String get showcaseLinkMedTitle => 'Link Medicine';

  @override
  String get showcaseLinkMedDesc =>
      'Tap here to select medicines taken at this time.';

  @override
  String get settingsHelp => 'Help & Support';

  @override
  String get settingsAppTutorial => 'App Tutorial';
}
