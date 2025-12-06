import 'package:agzakhaneti/app/di/service_locator.dart';
import 'package:agzakhaneti/app/services/database_service.dart';
import 'package:sqflite/sqflite.dart';
import '../models/health_reading_model.dart';

// --- (1) الجزء الأول: الـ "عقد" (تم إضافة update) ---
abstract class HealthLocalDataSource {
  Future<List<HealthReadingModel>> getAllHealthReadings();
  Future<void> addHealthReading(HealthReadingModel reading);
  Future<void> deleteHealthReading(int readingId);
  Future<void> updateHealthReading(HealthReadingModel reading); // <-- (جديد)
}

// --- (2) الجزء الثاني: الـ "تنفيذ" (تم إضافة update) ---
class HealthLocalDataSourceImpl implements HealthLocalDataSource {
  final DatabaseService _databaseService = sl<DatabaseService>();
  Future<Database> get _db async => await _databaseService.database;

  @override
  Future<void> addHealthReading(HealthReadingModel reading) async {
    final db = await _db;
    await db.insert(
      healthReadingsTable,
      reading.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteHealthReading(int readingId) async {
    final db = await _db;
    await db.delete(
      healthReadingsTable,
      where: '$colHealthId = ?',
      whereArgs: [readingId],
    );
  }

  @override
  Future<List<HealthReadingModel>> getAllHealthReadings() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      healthReadingsTable,
      orderBy: '$colHealthTimestamp DESC',
    );

    if (maps.isEmpty) {
      return [];
    }
    return List.generate(maps.length, (index) {
      return HealthReadingModel.fromMap(maps[index]);
    });
  }

  // --- (جديد) (3) إضافة تنفيذ دالة التعديل ---
  @override
  Future<void> updateHealthReading(HealthReadingModel reading) async {
    final db = await _db;
    await db.update(
      healthReadingsTable, // اسم الجدول
      reading.toMap(), // الداتا الجديدة
      where: '$colHealthId = ?', // الشرط
      whereArgs: [reading.id], // قيمة الشرط (لازم الـ ID يكون موجود)
    );
  }
}
