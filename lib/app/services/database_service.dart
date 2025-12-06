import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// (1) أسماء ثوابت زي ما هي
const String _dbName = 'agzakhaneti.db';

// --- جدول الأدوية (من المحور الأول) ---
const String medicationsTable = 'medications';
// ... (كل أعمدة colMed... زي ما هي)
const String colMedId = 'id';
const String colMedName = 'name';
const String colMedForm = 'form';
const String colMedDoseValue = 'doseValue';
const String colMedDoseUnit = 'doseUnit';
const String colMedCurrentStock = 'currentStock';
const String colMedRefillReminderStock = 'refillReminderStock';
const String colMedNotes = 'notes';

// --- جدول مجموعات المواعيد (المحور الثاني) ---
const String scheduleGroupsTable = 'schedule_groups';
// ... (كل أعمدة colGroup... زي ما هي)
const String colGroupId = 'groupId';
const String colGroupName = 'groupName';
const String colGroupHour = 'hour';
const String colGroupMinute = 'minute';
const String colGroupDaysOfWeek = 'daysOfWeek';
const String colGroupIsActive = 'isActive';

// --- جدول الربط (المحور الثاني) ---
const String scheduleLinkTable = 'schedule_medication_link';
// ... (كل أعمدة colLink... زي ما هي)
const String colLinkId = 'linkId';
const String colLinkGroupId = 'groupId';
const String colLinkMedicationId = 'medicationId';

// --- (جديد) جدول السجل الصحي (المحور الثالث) ---
const String healthReadingsTable = 'health_readings';
const String colHealthId = 'healthId'; // (PK)
const String colHealthType = 'type'; // ('blood_pressure', 'blood_sugar')
const String colHealthTimestamp = 'timestamp'; // (وقت التسجيل)
const String colHealthValueSystolic = 'systolic'; // (ضغط انقباضي)
const String colHealthValueDiastolic = 'diastolic'; // (ضغط انبساطي)
const String colHealthValueSugar = 'sugar_level'; // (مستوى السكر)
const String colHealthSugarStatus = 'sugar_status'; // (صايم، فاطر، عشوائي)
const String colHealthNotes = 'health_notes'; // (ملاحظات)

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + '/' + _dbName;

    return await openDatabase(
      path,
      version: 3, // <-- (جديد) رفعنا الإصدار من 2 إلى 3
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // الدالة دي هتتنفذ بس لو مستخدم جديد لسه منزل التطبيق
  Future<void> _onCreate(Database db, int version) async {
    // ----- إنشاء جدول الأدوية (Medications) -----
    await db.execute("""
      CREATE TABLE $medicationsTable (
        $colMedId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colMedName TEXT NOT NULL,
        $colMedForm TEXT NOT NULL,
        $colMedDoseValue REAL NOT NULL, 
        $colMedDoseUnit TEXT NOT NULL,
        $colMedCurrentStock REAL NOT NULL,
        $colMedRefillReminderStock REAL NOT NULL,
        $colMedNotes TEXT
      )
    """);

    // بنشغل دالة onUpgrade عشان حتى المستخدم الجديد
    // ياخد كل الجداول (بتاعة 2 و 3)
    await _onUpgrade(db, 1, version);
  }

  // الدالة دي هي اللي بتعمل التحديثات للمستخدمين القدامى
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // (الترقية من 1 إلى 2 - زي ما هي)
    if (oldVersion < 2) {
      // ----- إنشاء جدول مجموعات المواعيد (Schedule Groups) -----
      await db.execute("""
        CREATE TABLE $scheduleGroupsTable (
          $colGroupId INTEGER PRIMARY KEY AUTOINCREMENT,
          $colGroupName TEXT NOT NULL,
          $colGroupHour INTEGER NOT NULL,
          $colGroupMinute INTEGER NOT NULL,
          $colGroupDaysOfWeek TEXT NOT NULL,
          $colGroupIsActive INTEGER NOT NULL DEFAULT 1
        )
      """);

      // ----- إنشاء جدول الربط (Link Table) -----
      await db.execute("""
        CREATE TABLE $scheduleLinkTable (
          $colLinkId INTEGER PRIMARY KEY AUTOINCREMENT,
          $colLinkGroupId INTEGER NOT NULL,
          $colLinkMedicationId INTEGER NOT NULL,
          FOREIGN KEY ($colLinkGroupId) REFERENCES $scheduleGroupsTable ($colGroupId) ON DELETE CASCADE,
          FOREIGN KEY ($colLinkMedicationId) REFERENCES $medicationsTable ($colMedId) ON DELETE CASCADE
        )
      """);
    }

    // (جديد) الترقية من 2 إلى 3
    if (oldVersion < 3) {
      // ----- إنشاء جدول السجل الصحي (Health Readings) -----
      await db.execute("""
        CREATE TABLE $healthReadingsTable (
          $colHealthId INTEGER PRIMARY KEY AUTOINCREMENT,
          $colHealthType TEXT NOT NULL,
          $colHealthTimestamp TEXT NOT NULL,
          $colHealthValueSystolic INTEGER,
          $colHealthValueDiastolic INTEGER,
          $colHealthValueSugar REAL,
          $colHealthSugarStatus TEXT,
          $colHealthNotes TEXT
        )
      """);
    }

    // (مستقبلاً) لو عملنا version 4، هنكتب:
    // if (oldVersion < 4) {
    //   // ... ADD TABLE ...
    // }
  }
}
