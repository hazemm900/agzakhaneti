import 'package:agzakhaneti/app/services/database_service.dart';
import 'package:agzakhaneti/app/utils/enums.dart';

import '../../domain/entities/health_reading.dart'; // (3) الـ Entity

// (4) الـ Model بيورث من الـ Entity
class HealthReadingModel extends HealthReading {
  const HealthReadingModel({
    super.id,
    required super.type,
    required super.timestamp,
    super.systolic,
    super.diastolic,
    super.sugarLevel,
    super.sugarStatus,
    super.notes,
  });

  // --- (5) الدالة الأهم: التحويل من Map (الداتابيز) إلى Object ---
  factory HealthReadingModel.fromMap(Map<String, dynamic> map) {
    return HealthReadingModel(
      id: map[colHealthId] as int?,

      // تحويل الـ String اللي في الداتابيز لـ Enum
      type: HealthReadingType.values.firstWhere(
        (e) => e.toString() == map[colHealthType],
      ),

      // تحويل الـ String (ISO 8601) لـ DateTime
      timestamp: DateTime.parse(map[colHealthTimestamp] as String),

      // قراءة القيم الـ nullable
      systolic: map[colHealthValueSystolic] as int?,
      diastolic: map[colHealthValueDiastolic] as int?,
      sugarLevel: map[colHealthValueSugar] as double?,

      // تحويل الـ String (الـ nullable) لـ Enum (nullable)
      sugarStatus: map[colHealthSugarStatus] == null
          ? null
          : BloodSugarStatus.values.firstWhere(
              (e) => e.toString() == map[colHealthSugarStatus],
            ),

      notes: map[colHealthNotes] as String?,
    );
  }

  // --- (6) الدالة التانية: التحويل من Object إلى Map (للداتابيز) ---
  Map<String, dynamic> toMap() {
    return {
      if (id != null) colHealthId: id,

      // تحويل الـ Enum لـ String
      colHealthType: type.toString(),

      // تحويل الـ DateTime لـ String (بصيغة ISO 8601 القياسية)
      colHealthTimestamp: timestamp.toIso8601String(),

      // إضافة القيم (هتتخزن كـ null لو هي null)
      colHealthValueSystolic: systolic,
      colHealthValueDiastolic: diastolic,
      colHealthValueSugar: sugarLevel,

      // تحويل الـ Enum (الـ nullable) لـ String (nullable)
      colHealthSugarStatus: sugarStatus?.toString(),

      colHealthNotes: notes,
    };
  }
}
