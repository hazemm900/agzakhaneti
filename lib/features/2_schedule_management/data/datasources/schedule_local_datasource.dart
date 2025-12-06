import 'package:agzakhaneti/app/di/service_locator.dart';
import 'package:agzakhaneti/app/services/database_service.dart';
import 'package:sqflite/sqflite.dart';
// (1) هنحتاج الموديل بتاع الأدوية (من المحور الأول)
import '../../../1_medications_management/data/models/medication_model.dart';
// (2) وهنحتاج الموديل بتاع المواعيد (من المحور الثاني)
import '../models/schedule_group_model.dart';

// --- (3) الجزء الأول: الـ "عقد" أو الـ Interface ---
abstract class ScheduleLocalDataSource {
  Future<List<ScheduleGroupModel>> getAllScheduleGroups();
  Future<void> addScheduleGroup(ScheduleGroupModel group);
  Future<void> updateScheduleGroup(ScheduleGroupModel group);
  Future<void> deleteScheduleGroup(int groupId);

  Future<void> linkMedicationToGroup({
    required int groupId,
    required int medicationId,
  });
  Future<void> unlinkMedicationFromGroup({
    required int groupId,
    required int medicationId,
  });
  Future<List<MedicationModel>> getMedicationsForGroup(int groupId);
}

// --- (4) الجزء الثاني: الـ "تنفيذ" الفعلي ---
class ScheduleLocalDataSourceImpl implements ScheduleLocalDataSource {
  final DatabaseService _databaseService = sl<DatabaseService>();
  Future<Database> get _db async => await _databaseService.database;

  // --- (أ) عمليات "مجموعة المواعيد" ---

  @override
  Future<void> addScheduleGroup(ScheduleGroupModel group) async {
    final db = await _db;
    await db.insert(
      scheduleGroupsTable,
      group.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteScheduleGroup(int groupId) async {
    final db = await _db;
    await db.delete(
      scheduleGroupsTable,
      where: '$colGroupId = ?',
      whereArgs: [groupId],
    );
    // (ملحوظة: ON DELETE CASCADE اللي في الداتابيز هيمسح الروابط في جدول
    // scheduleLinkTable أوتوماتيك)
  }

  @override
  Future<List<ScheduleGroupModel>> getAllScheduleGroups() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(scheduleGroupsTable);

    if (maps.isEmpty) {
      return [];
    }
    return List.generate(maps.length, (index) {
      return ScheduleGroupModel.fromMap(maps[index]);
    });
  }

  @override
  Future<void> updateScheduleGroup(ScheduleGroupModel group) async {
    final db = await _db;
    await db.update(
      scheduleGroupsTable,
      group.toMap(),
      where: '$colGroupId = ?',
      whereArgs: [group.id],
    );
  }

  // --- (ب) عمليات "الربط" ---

  @override
  Future<void> linkMedicationToGroup({
    required int groupId,
    required int medicationId,
  }) async {
    final db = await _db;
    await db.insert(
      scheduleLinkTable,
      {colLinkGroupId: groupId, colLinkMedicationId: medicationId},
      conflictAlgorithm:
          ConflictAlgorithm.ignore, // (لو اللينك موجود، متعملش حاجة)
    );
  }

  @override
  Future<void> unlinkMedicationFromGroup({
    required int groupId,
    required int medicationId,
  }) async {
    final db = await _db;
    await db.delete(
      scheduleLinkTable,
      // (لازم الشرط يكون على العمودين مع بعض)
      where: '$colLinkGroupId = ? AND $colLinkMedicationId = ?',
      whereArgs: [groupId, medicationId],
    );
  }

  // --- (ج) عملية "الجلب بالربط" (الأهم) ---

  @override
  Future<List<MedicationModel>> getMedicationsForGroup(int groupId) async {
    final db = await _db;

    // (5) دي "الجوهرة": استعلام SQL معقد (JOIN)
    // "هاتلي كل الأعمدة (*) من جدول الأدوية (medicationsTable)
    //  بشرط إنك تعمل JOIN (ربط) مع جدول اللينكات (scheduleLinkTable)
    //  بحيث الـ ID بتاع الدواء (colMedId) يساوي الـ ID اللي في اللينك (colLinkMedicationId)
    //  وبشرط (WHERE) إن الـ ID بتاع المجموعة (colLinkGroupId) يكون هو اللي أنا باعتهولك"
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      """
      SELECT T1.* FROM $medicationsTable AS T1
      INNER JOIN $scheduleLinkTable AS T2
      ON T1.$colMedId = T2.$colLinkMedicationId
      WHERE T2.$colLinkGroupId = ?
    """,
      [groupId],
    );

    // (6) باقي الكود عادي: بنحول الـ Maps لـ Models
    if (maps.isEmpty) {
      return [];
    }
    return List.generate(maps.length, (index) {
      return MedicationModel.fromMap(maps[index]);
    });
  }
}
