import 'package:agzakhaneti/app/utils/enums.dart';
import 'package:equatable/equatable.dart';
// (1) بنستورد الـ Enums اللي لسه عاملينها

// (2) بنخليه يورث من Equatable
class HealthReading extends Equatable {
  // (3) الـ ID (nullable كالعادة)
  final int? id;

  // (4) نوع القراءة (ضغط ولا سكر)
  final HealthReadingType type;

  // (5) وقت وتاريخ التسجيل
  final DateTime timestamp;

  // (6) القيم (معظمها nullable)

  // --- في حالة الضغط ---
  final int? systolic; // (الانقباضي - "اللي فوق")
  final int? diastolic; // (الانبساطي - "اللي تحت")

  // --- في حالة السكر ---
  final double? sugarLevel; // (مستوى السكر)
  final BloodSugarStatus? sugarStatus; // (حالة القياس)

  // --- ملاحظات عامة ---
  final String? notes; // (اختياري)

  const HealthReading({
    this.id,
    required this.type,
    required this.timestamp,
    // بنخلي الباقي اختياري لأنهم بيعتمدوا على النوع
    this.systolic,
    this.diastolic,
    this.sugarLevel,
    this.sugarStatus,
    this.notes,
  });

  // (7) الـ props عشان الـ Equatable
  @override
  List<Object?> get props => [
    id,
    type,
    timestamp,
    systolic,
    diastolic,
    sugarLevel,
    sugarStatus,
    notes,
  ];
}
