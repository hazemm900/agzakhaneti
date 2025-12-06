import 'package:agzakhaneti/app/di/service_locator.dart';
import 'package:agzakhaneti/app/services/database_service.dart';
import 'package:sqflite/sqflite.dart';
import '../models/medication_model.dart';

// --- (3) الجزء الأول: الـ "عقد" أو الـ Interface ---
// ده بيعرف إيه العمليات اللي الـ DataSource ده بيعملها
abstract class MedicationLocalDataSource {
  Future<List<MedicationModel>> getAllMedications();
  Future<void> addMedication(MedicationModel medication);
  Future<void> updateMedication(MedicationModel medication);
  Future<void> deleteMedication(int id);
}

// --- (4) الجزء الثاني: الـ "تنفيذ" الفعلي للـ Interface ---
class MedicationLocalDataSourceImpl implements MedicationLocalDataSource {
  // (5) بنعتمد على DatabaseService اللي عملناه في الـ Service Locator
  // مبنعملش new()، بنطلبها من get_it
  final DatabaseService _databaseService = sl<DatabaseService>();

  // (6) دالة مساعدة عشان تجيب "الاتصال" بالداتابيز
  Future<Database> get _db async => await _databaseService.database;

  @override
  Future<void> addMedication(MedicationModel medication) async {
    final db = await _db;
    // بنستخدم دالة `toMap` اللي في الموديل عشان نحول الـ object لـ Map
    await db.insert(
      medicationsTable, // اسم الجدول
      medication.toMap(), // الداتا
      conflictAlgorithm: ConflictAlgorithm.replace, // لو الـ ID موجود، استبدله
    );
  }

  @override
  Future<void> deleteMedication(int id) async {
    final db = await _db;
    await db.delete(
      medicationsTable, // اسم الجدول
      where: '$colMedId = ?', // الشرط
      whereArgs: [id], // قيمة الشرط
    );
  }

  @override
  Future<List<MedicationModel>> getAllMedications() async {
    final db = await _db;

    // بنستعلم عن كل البيانات اللي في الجدول
    final List<Map<String, dynamic>> maps = await db.query(medicationsTable);

    // لو القايمة فاضية، رجع قايمة فاضية
    if (maps.isEmpty) {
      return [];
    }

    // لو فيها بيانات، لف على كل Map وحولها لـ MedicationModel
    // باستخدام دالة `fromMap` اللي عملناها
    return List.generate(maps.length, (index) {
      return MedicationModel.fromMap(maps[index]);
    });
  }

  @override
  Future<void> updateMedication(MedicationModel medication) async {
    final db = await _db;
    await db.update(
      medicationsTable, // اسم الجدول
      medication.toMap(), // الداتا الجديدة
      where: '$colMedId = ?', // الشرط
      whereArgs: [medication.id], // قيمة الشرط (لازم الـ ID يكون موجود)
    );
  }
}
