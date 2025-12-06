import 'package:agzakhaneti/app/utils/enums.dart';
import 'package:equatable/equatable.dart';

class Medication extends Equatable {
  final int? id;
  final String name;
  final MedicationForm form;

  final double doseValue;
  final DoseUnit doseUnit;

  final double currentStock;
  final double refillReminderStock;
  final String? notes;

  const Medication({
    this.id,
    required this.name,
    required this.form,
    required this.doseValue,
    required this.doseUnit,
    required this.currentStock,
    required this.refillReminderStock,
    this.notes,
  });

  // (جديد) دي الدالة اللي كانت ناقصة
  // بتسمح لنا نعدل حقل واحد بس (زي المخزون) ونحافظ على الباقي
  Medication copyWith({
    int? id,
    String? name,
    MedicationForm? form,
    double? doseValue,
    DoseUnit? doseUnit,
    double? currentStock,
    double? refillReminderStock,
    String? notes,
  }) {
    return Medication(
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

  @override
  List<Object?> get props => [
    id,
    name,
    form,
    doseValue,
    doseUnit,
    currentStock,
    refillReminderStock,
    notes,
  ];
}
