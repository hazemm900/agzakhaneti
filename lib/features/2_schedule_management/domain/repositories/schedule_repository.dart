// (1) بنستورد الـ Entity بتاع المواعيد
import '../entities/schedule_group.dart';
// (2) (مهم) هنستورد الـ Entity بتاع الدواء من المحور الأول!
import '../../../1_medications_management/domain/entities/medication.dart';

// (3) العقد المجرد (Abstract Interface)
abstract class ScheduleRepository {
  // --- (أ) عمليات خاصة بـ "مجموعة المواعيد" نفسها ---

  /// جلب كل مجموعات المواعيد (زي "جرعة الصباح"، "جرعة المساء")
  Future<List<ScheduleGroup>> getAllScheduleGroups();

  /// إضافة مجموعة مواعيد جديدة
  Future<void> addScheduleGroup(ScheduleGroup group);

  /// تعديل مجموعة مواعيد (تغيير الوقت، الاسم، أو تفعيل/تعطيل)
  Future<void> updateScheduleGroup(ScheduleGroup group);

  /// حذف مجموعة مواعيد (عن طريق الـ ID)
  Future<void> deleteScheduleGroup(int groupId);

  // --- (ب) عمليات خاصة بـ "ربط" الأدوية بالمجموعات ---
  // (دي العمليات اللي هتشتغل على جدول scheduleLinkTable)

  /// إضافة (ربط) دواء معين بمجموعة معينة
  Future<void> linkMedicationToGroup({
    required int groupId,
    required int medicationId,
  });

  /// فك (حذف) ربط دواء معين من مجموعة معينة
  Future<void> unlinkMedicationFromGroup({
    required int groupId,
    required int medicationId,
  });

  /// جلب كل الأدوية المرتبطة بمجموعة معينة (عشان نعرضها للمستخدم)
  Future<List<Medication>> getMedicationsForGroup(int groupId);
}
