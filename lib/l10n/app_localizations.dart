import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Agzakhaneti'**
  String get appTitle;

  /// No description provided for @myMedications.
  ///
  /// In en, this message translates to:
  /// **'Medications'**
  String get myMedications;

  /// No description provided for @mySchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get mySchedule;

  /// No description provided for @healthLog.
  ///
  /// In en, this message translates to:
  /// **'Health Log'**
  String get healthLog;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'required field'**
  String get requiredField;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred:'**
  String get errorOccurred;

  /// No description provided for @unknownState.
  ///
  /// In en, this message translates to:
  /// **'Unknown state'**
  String get unknownState;

  /// No description provided for @addMedication.
  ///
  /// In en, this message translates to:
  /// **'Add Medication'**
  String get addMedication;

  /// No description provided for @addNewMedication.
  ///
  /// In en, this message translates to:
  /// **'Add New Medication'**
  String get addNewMedication;

  /// No description provided for @noMedications.
  ///
  /// In en, this message translates to:
  /// **'No medications found. Tap + to add.'**
  String get noMedications;

  /// No description provided for @noMedicationsList.
  ///
  /// In en, this message translates to:
  /// **'No medications available. Tap + to add your first one.'**
  String get noMedicationsList;

  /// No description provided for @editMedication.
  ///
  /// In en, this message translates to:
  /// **'Edit Medicine'**
  String get editMedication;

  /// No description provided for @deleteMedication.
  ///
  /// In en, this message translates to:
  /// **'Delete Medication'**
  String get deleteMedication;

  /// No description provided for @medicineName.
  ///
  /// In en, this message translates to:
  /// **'Medicine Name'**
  String get medicineName;

  /// No description provided for @medicineShape.
  ///
  /// In en, this message translates to:
  /// **'Medicine Form'**
  String get medicineShape;

  /// No description provided for @chooseMedicineShape.
  ///
  /// In en, this message translates to:
  /// **'Choose medicine form...'**
  String get chooseMedicineShape;

  /// No description provided for @doseAmountWith.
  ///
  /// In en, this message translates to:
  /// **'Dose amount in '**
  String get doseAmountWith;

  /// No description provided for @currentStockWith.
  ///
  /// In en, this message translates to:
  /// **'Current stock in '**
  String get currentStockWith;

  /// No description provided for @alertMeWhenStockComesTo.
  ///
  /// In en, this message translates to:
  /// **'Alert me when stock reaches '**
  String get alertMeWhenStockComesTo;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get notes;

  /// No description provided for @example.
  ///
  /// In en, this message translates to:
  /// **'Example: before eating, on an empty stomach...'**
  String get example;

  /// No description provided for @saveEdits.
  ///
  /// In en, this message translates to:
  /// **'Save Edits'**
  String get saveEdits;

  /// No description provided for @saveMedicine.
  ///
  /// In en, this message translates to:
  /// **'Save Medicine'**
  String get saveMedicine;

  /// No description provided for @currentStock.
  ///
  /// In en, this message translates to:
  /// **'Current stock'**
  String get currentStock;

  /// No description provided for @dose.
  ///
  /// In en, this message translates to:
  /// **'Dose'**
  String get dose;

  /// No description provided for @takeDose.
  ///
  /// In en, this message translates to:
  /// **'Record dose taken'**
  String get takeDose;

  /// No description provided for @confirmDose.
  ///
  /// In en, this message translates to:
  /// **'Confirm Dose'**
  String get confirmDose;

  /// No description provided for @tookDoseQuestion.
  ///
  /// In en, this message translates to:
  /// **'Did you take a dose of {medicine} now?\n{amount} will be deducted from stock.'**
  String tookDoseQuestion(Object amount, Object medicine);

  /// No description provided for @doseTakenSuccess.
  ///
  /// In en, this message translates to:
  /// **'Dose for {medicine} has been deducted successfully.'**
  String doseTakenSuccess(Object medicine);

  /// No description provided for @capsule.
  ///
  /// In en, this message translates to:
  /// **'pill'**
  String get capsule;

  /// No description provided for @mM.
  ///
  /// In en, this message translates to:
  /// **'ml'**
  String get mM;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'unit'**
  String get unit;

  /// No description provided for @puff.
  ///
  /// In en, this message translates to:
  /// **'puff'**
  String get puff;

  /// No description provided for @drop.
  ///
  /// In en, this message translates to:
  /// **'drop'**
  String get drop;

  /// No description provided for @use.
  ///
  /// In en, this message translates to:
  /// **'application'**
  String get use;

  /// No description provided for @addNewSchedule.
  ///
  /// In en, this message translates to:
  /// **'Add New Schedule'**
  String get addNewSchedule;

  /// No description provided for @editSchedule.
  ///
  /// In en, this message translates to:
  /// **'Edit Schedule'**
  String get editSchedule;

  /// No description provided for @scheduleName.
  ///
  /// In en, this message translates to:
  /// **'Schedule Name'**
  String get scheduleName;

  /// No description provided for @scheduleNameHint.
  ///
  /// In en, this message translates to:
  /// **'Example: Morning dose'**
  String get scheduleNameHint;

  /// No description provided for @pickTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Choose time:'**
  String get pickTimeLabel;

  /// No description provided for @pickTimeHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to choose time'**
  String get pickTimeHint;

  /// No description provided for @repeatDays.
  ///
  /// In en, this message translates to:
  /// **'Repeat (days):'**
  String get repeatDays;

  /// No description provided for @chooseTimeError.
  ///
  /// In en, this message translates to:
  /// **'Please choose a time'**
  String get chooseTimeError;

  /// No description provided for @chooseDayError.
  ///
  /// In en, this message translates to:
  /// **'Please choose at least one day'**
  String get chooseDayError;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @saveSchedule.
  ///
  /// In en, this message translates to:
  /// **'Save schedule'**
  String get saveSchedule;

  /// No description provided for @noLinkedMedications.
  ///
  /// In en, this message translates to:
  /// **'No medications linked to this schedule yet.'**
  String get noLinkedMedications;

  /// No description provided for @unlinkMedicationTooltip.
  ///
  /// In en, this message translates to:
  /// **'Unlink medication from schedule'**
  String get unlinkMedicationTooltip;

  /// No description provided for @linkMedicationTooltip.
  ///
  /// In en, this message translates to:
  /// **'Link medication to this schedule'**
  String get linkMedicationTooltip;

  /// No description provided for @noSchedulesFound.
  ///
  /// In en, this message translates to:
  /// **'No schedules created yet. Tap + to add your first schedule.'**
  String get noSchedulesFound;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @editScheduleTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit schedule'**
  String get editScheduleTooltip;

  /// No description provided for @deleteScheduleTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete schedule'**
  String get deleteScheduleTooltip;

  /// No description provided for @linkMedicationToSchedule.
  ///
  /// In en, this message translates to:
  /// **'Link Medication to Schedule'**
  String get linkMedicationToSchedule;

  /// No description provided for @allMedicationsLinked.
  ///
  /// In en, this message translates to:
  /// **'Great! All medications are already linked to this schedule or the inventory is empty.'**
  String get allMedicationsLinked;

  /// No description provided for @linkThisMedication.
  ///
  /// In en, this message translates to:
  /// **'Link this medication'**
  String get linkThisMedication;

  /// No description provided for @addNewReading.
  ///
  /// In en, this message translates to:
  /// **'Add New Reading'**
  String get addNewReading;

  /// No description provided for @editHealthReading.
  ///
  /// In en, this message translates to:
  /// **'Edit Reading'**
  String get editHealthReading;

  /// No description provided for @chooseReadingType.
  ///
  /// In en, this message translates to:
  /// **'Choose reading type:'**
  String get chooseReadingType;

  /// No description provided for @saveHealthReading.
  ///
  /// In en, this message translates to:
  /// **'Save Reading'**
  String get saveHealthReading;

  /// No description provided for @saveHealthReadingEdits.
  ///
  /// In en, this message translates to:
  /// **'Save Edits'**
  String get saveHealthReadingEdits;

  /// No description provided for @systolicPressure.
  ///
  /// In en, this message translates to:
  /// **'Systolic Pressure (High)'**
  String get systolicPressure;

  /// No description provided for @diastolicPressure.
  ///
  /// In en, this message translates to:
  /// **'Diastolic Pressure (Low)'**
  String get diastolicPressure;

  /// No description provided for @bloodSugarLevel.
  ///
  /// In en, this message translates to:
  /// **'Blood Sugar Level (mg/dL)'**
  String get bloodSugarLevel;

  /// No description provided for @bloodSugarStatus.
  ///
  /// In en, this message translates to:
  /// **'Blood Sugar Status'**
  String get bloodSugarStatus;

  /// No description provided for @chooseSugarStatusHint.
  ///
  /// In en, this message translates to:
  /// **'Choose sugar status...'**
  String get chooseSugarStatusHint;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get invalidNumber;

  /// No description provided for @chooseReadingTypeFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select a reading type first'**
  String get chooseReadingTypeFirst;

  /// No description provided for @healthLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Health Log'**
  String get healthLogTitle;

  /// No description provided for @healthLogTabList.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get healthLogTabList;

  /// No description provided for @healthLogTabReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get healthLogTabReports;

  /// No description provided for @healthLogErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {message}'**
  String healthLogErrorOccurred(Object message);

  /// No description provided for @healthLogNoData.
  ///
  /// In en, this message translates to:
  /// **'No data to plot reports. Start by adding readings first.'**
  String get healthLogNoData;

  /// No description provided for @healthLogBloodPressureReport.
  ///
  /// In en, this message translates to:
  /// **'Blood Pressure Report'**
  String get healthLogBloodPressureReport;

  /// No description provided for @healthLogBloodPressureNeedTwo.
  ///
  /// In en, this message translates to:
  /// **'(Need at least two readings to plot report)'**
  String get healthLogBloodPressureNeedTwo;

  /// No description provided for @healthLogBloodSugarReport.
  ///
  /// In en, this message translates to:
  /// **'Blood Sugar Report'**
  String get healthLogBloodSugarReport;

  /// No description provided for @healthLogBloodSugarNeedTwo.
  ///
  /// In en, this message translates to:
  /// **'(Need at least two readings to plot report)'**
  String get healthLogBloodSugarNeedTwo;

  /// No description provided for @healthLogUnknownState.
  ///
  /// In en, this message translates to:
  /// **'Unknown state'**
  String get healthLogUnknownState;

  /// No description provided for @healthLogNoReadings.
  ///
  /// In en, this message translates to:
  /// **'No readings recorded. Press + to add your first reading.'**
  String get healthLogNoReadings;

  /// No description provided for @healthLogUnknownReading.
  ///
  /// In en, this message translates to:
  /// **'Unknown reading'**
  String get healthLogUnknownReading;

  /// No description provided for @healthLogBloodPressureTitle.
  ///
  /// In en, this message translates to:
  /// **'Blood Pressure Measurement'**
  String get healthLogBloodPressureTitle;

  /// No description provided for @healthLogBloodPressureLabel.
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get healthLogBloodPressureLabel;

  /// No description provided for @healthLogBloodSugarTitle.
  ///
  /// In en, this message translates to:
  /// **'Blood Sugar Measurement'**
  String get healthLogBloodSugarTitle;

  /// No description provided for @healthLogBloodSugarLabel.
  ///
  /// In en, this message translates to:
  /// **'Sugar'**
  String get healthLogBloodSugarLabel;

  /// No description provided for @healthLogEditReading.
  ///
  /// In en, this message translates to:
  /// **'Edit Reading'**
  String get healthLogEditReading;

  /// No description provided for @healthLogDeleteReading.
  ///
  /// In en, this message translates to:
  /// **'Delete Reading'**
  String get healthLogDeleteReading;

  /// No description provided for @bloodSugarFasting.
  ///
  /// In en, this message translates to:
  /// **'Fasting'**
  String get bloodSugarFasting;

  /// No description provided for @bloodSugarPostMeal.
  ///
  /// In en, this message translates to:
  /// **'Post Meal'**
  String get bloodSugarPostMeal;

  /// No description provided for @bloodSugarRandom.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get bloodSugarRandom;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsSystemTheme.
  ///
  /// In en, this message translates to:
  /// **'System Theme'**
  String get settingsSystemTheme;

  /// No description provided for @settingsFollowDevice.
  ///
  /// In en, this message translates to:
  /// **'Follows device settings'**
  String get settingsFollowDevice;

  /// No description provided for @settingsLightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get settingsLightTheme;

  /// No description provided for @settingsDarkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get settingsDarkTheme;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsSystemLanguage.
  ///
  /// In en, this message translates to:
  /// **'System Language'**
  String get settingsSystemLanguage;

  /// No description provided for @settingsArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get settingsArabic;

  /// No description provided for @settingsEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsEnglish;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsAboutApp.
  ///
  /// In en, this message translates to:
  /// **'About Agzakhaneti'**
  String get settingsAboutApp;

  /// No description provided for @settingsContactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get settingsContactUs;

  /// No description provided for @notificationsLowStockTitle.
  ///
  /// In en, this message translates to:
  /// **'Medications (Low Stock)'**
  String get notificationsLowStockTitle;

  /// No description provided for @notificationsStockOk.
  ///
  /// In en, this message translates to:
  /// **'Your stock is fine!'**
  String get notificationsStockOk;

  /// No description provided for @notificationsNoLowStock.
  ///
  /// In en, this message translates to:
  /// **'No medications are about to run out.'**
  String get notificationsNoLowStock;

  /// No description provided for @notificationsCurrentStock.
  ///
  /// In en, this message translates to:
  /// **'Current Stock:'**
  String get notificationsCurrentStock;

  /// No description provided for @notificationsRefillReminder.
  ///
  /// In en, this message translates to:
  /// **'Refill Reminder:'**
  String get notificationsRefillReminder;

  /// No description provided for @notificationsNoData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get notificationsNoData;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get sat;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fri;

  /// No description provided for @formPill.
  ///
  /// In en, this message translates to:
  /// **'Pill/Capsule'**
  String get formPill;

  /// No description provided for @formSyrup.
  ///
  /// In en, this message translates to:
  /// **'Syrup'**
  String get formSyrup;

  /// No description provided for @formInjection.
  ///
  /// In en, this message translates to:
  /// **'Injection'**
  String get formInjection;

  /// No description provided for @formInhaler.
  ///
  /// In en, this message translates to:
  /// **'Inhaler'**
  String get formInhaler;

  /// No description provided for @formDrops.
  ///
  /// In en, this message translates to:
  /// **'Drops'**
  String get formDrops;

  /// No description provided for @formCream.
  ///
  /// In en, this message translates to:
  /// **'Cream/Ointment'**
  String get formCream;

  /// No description provided for @formOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get formOther;

  /// No description provided for @unitOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get unitOther;

  /// No description provided for @helpScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Tutorials'**
  String get helpScreenTitle;

  /// No description provided for @appTourSection.
  ///
  /// In en, this message translates to:
  /// **'App Tour'**
  String get appTourSection;

  /// No description provided for @resetTourTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset App Tour'**
  String get resetTourTitle;

  /// No description provided for @resetTourSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot how it works? Tap here to restart the walkthrough.'**
  String get resetTourSubtitle;

  /// No description provided for @resetTourSuccess.
  ///
  /// In en, this message translates to:
  /// **'Reset done! Return to Home Screen to start.'**
  String get resetTourSuccess;

  /// No description provided for @videoTutorialsSection.
  ///
  /// In en, this message translates to:
  /// **'Video Tutorials'**
  String get videoTutorialsSection;

  /// No description provided for @videoAddMedicationTitle.
  ///
  /// In en, this message translates to:
  /// **'1. Adding Medicine & Stock Tracking'**
  String get videoAddMedicationTitle;

  /// No description provided for @videoScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'2. Setting Schedules & Linking'**
  String get videoScheduleTitle;

  /// No description provided for @videoHealthLogTitle.
  ///
  /// In en, this message translates to:
  /// **'3. Health Log & Reports'**
  String get videoHealthLogTitle;

  /// No description provided for @showcaseAddMedTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Medicine'**
  String get showcaseAddMedTitle;

  /// No description provided for @showcaseAddMedDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap here to add a new medicine and track its stock.'**
  String get showcaseAddMedDesc;

  /// No description provided for @showcaseAddScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Schedule'**
  String get showcaseAddScheduleTitle;

  /// No description provided for @showcaseAddScheduleDesc.
  ///
  /// In en, this message translates to:
  /// **'Schedule your dose times (Breakfast, Lunch, Dinner).'**
  String get showcaseAddScheduleDesc;

  /// No description provided for @showcaseLinkMedTitle.
  ///
  /// In en, this message translates to:
  /// **'Link Medicine'**
  String get showcaseLinkMedTitle;

  /// No description provided for @showcaseLinkMedDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap here to select medicines taken at this time.'**
  String get showcaseLinkMedDesc;

  /// No description provided for @settingsHelp.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get settingsHelp;

  /// No description provided for @settingsAppTutorial.
  ///
  /// In en, this message translates to:
  /// **'App Tutorial'**
  String get settingsAppTutorial;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
