import 'package:agzakhaneti/app/services/database_service.dart';
import 'package:agzakhaneti/app/utils/enums.dart';

import '../../domain/entities/medication.dart'; // (3) بنورث من الـ Entity

// (4) الـ Model بيورث من الـ Entity
// ده بيخليه ياخد كل الخصائص (name, id, etc.)
// وفي نفس الوقت بنزود عليه دوال الداتابيز
class MedicationModel extends Medication {
  const MedicationModel({
    super.id,
    required super.name,
    required super.form,
    required super.doseValue,
    required super.doseUnit,
    required super.currentStock,
    required super.refillReminderStock,
    super.notes,
  });

  // --- (5) الدالة الأهم: التحويل من Map (الداتابيز) إلى Object (الـ Model) ---
  factory MedicationModel.fromMap(Map<String, dynamic> map) {
    return MedicationModel(
      // بنستخدم الثوابت اللي في database_service عشان نضمن إننا بنقرأ العمود الصح
      id: map[colMedId] as int?,
      name: map[colMedName] as String,

      // تحويل الـ String اللي في الداتابيز لـ Enum
      form: MedicationForm.values.firstWhere(
        (e) => e.toString() == map[colMedForm],
      ),

      doseValue: map[colMedDoseValue] as double,

      // تحويل الـ String اللي في الداتابيز لـ Enum
      doseUnit: DoseUnit.values.firstWhere(
        (e) => e.toString() == map[colMedDoseUnit],
      ),

      currentStock: map[colMedCurrentStock] as double,
      refillReminderStock: map[colMedRefillReminderStock] as double,
      notes: map[colMedNotes] as String?,
    );
  }

  // --- (6) الدالة التانية: التحويل من Object (الـ Model) إلى Map (للداتابيز) ---
  Map<String, dynamic> toMap() {
    return {
      // الـ ID مش بنحطه هنا لو هو null
      // الداتابيز (AUTOINCREMENT) هي اللي بتحطه
      if (id != null) colMedId: id,
      colMedName: name,

      // بنحول الـ Enum لـ String عشان يتخزن
      colMedForm: form.toString(),
      colMedDoseValue: doseValue,
      colMedDoseUnit: doseUnit.toString(),
      colMedCurrentStock: currentStock,
      colMedRefillReminderStock: refillReminderStock,
      colMedNotes: notes,
    };
  }

  // (7) دالة مساعدة عشان ننسخ الـ object بس نغير فيه حاجة (مفيدة للـ Cubit)
  MedicationModel copyWith({
    int? id,
    String? name,
    MedicationForm? form,
    double? doseValue,
    DoseUnit? doseUnit,
    double? currentStock,
    double? refillReminderStock,
    String? notes,
  }) {
    return MedicationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      form: form ?? this.form,
      doseValue: doseValue ?? this.doseValue,
      doseUnit: doseUnit ?? this.doseUnit,
      currentStock: currentStock ?? this.currentStock,
      refillReminderStock: refillReminderStock ?? this.refillReminderStock,
      notes: notes ?? this.notes,
    );
  }
}
