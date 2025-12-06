import 'package:flutter/material.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart'; // تأكد من المسار

// (1) أشكال الدواء
enum MedicationForm {
  pill,
  syrup,
  injection,
  inhaler,
  drops,
  cream,
  other;

  String getDisplayName(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    switch (this) {
      case MedicationForm.pill:
        return loc.formPill;
      case MedicationForm.syrup:
        return loc.formSyrup;
      case MedicationForm.injection:
        return loc.formInjection;
      case MedicationForm.inhaler:
        return loc.formInhaler;
      case MedicationForm.drops:
        return loc.formDrops;
      case MedicationForm.cream:
        return loc.formCream;
      case MedicationForm.other:
        return loc.formOther;
    }
  }
}

// (2) وحدات الجرعة
enum DoseUnit {
  pill,
  ml,
  unit,
  puff,
  drop,
  application,
  other;

  String getDisplayName(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    switch (this) {
      case DoseUnit.pill:
        return loc.capsule; // موجودة عندك في الـ JSON
      case DoseUnit.ml:
        return loc.mM; // موجودة
      case DoseUnit.unit:
        return loc.unit; // موجودة
      case DoseUnit.puff:
        return loc.puff; // موجودة
      case DoseUnit.drop:
        return loc.drop; // موجودة
      case DoseUnit.application:
        return loc.use; // موجودة
      case DoseUnit.other:
        return loc.unitOther; // ضفناها جديد
    }
  }
}

// (3) أنواع القياسات الصحية
enum HealthReadingType {
  bloodPressure,
  bloodSugar;

  String getDisplayName(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    switch (this) {
      case HealthReadingType.bloodPressure:
        return loc.healthLogBloodPressureLabel; // موجودة "الضغط"
      case HealthReadingType.bloodSugar:
        return loc.healthLogBloodSugarLabel; // موجودة "السكر"
    }
  }
}

// (4) حالة قياس السكر
enum BloodSugarStatus {
  fasting,
  postMeal,
  random;

  String getDisplayName(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    switch (this) {
      case BloodSugarStatus.fasting:
        return loc.bloodSugarFasting; // موجودة
      case BloodSugarStatus.postMeal:
        return loc.bloodSugarPostMeal; // موجودة
      case BloodSugarStatus.random:
        return loc.bloodSugarRandom; // موجودة
    }
  }
}
