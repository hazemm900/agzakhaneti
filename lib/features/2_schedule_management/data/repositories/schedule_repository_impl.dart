// (1) بنستورد الـ Entities (بتاعة المحورين)
import '../../../1_medications_management/domain/entities/medication.dart';
import '../../domain/entities/schedule_group.dart';

// (2) بنستورد العقد اللي هننفذه
import '../../domain/repositories/schedule_repository.dart';

// (3) بنستورد الـ DataSource والموديل بتاعنا
import '../datasources/schedule_local_datasource.dart';
import '../models/schedule_group_model.dart';

// (4) بنعمل "implements" للعقد بتاعنا
class ScheduleRepositoryImpl implements ScheduleRepository {
  // (5) بنعتمد على الـ DataSource
  final ScheduleLocalDataSource localDataSource;

  // (6) بنعمله "حقن" (Inject) في الـ Constructor
  ScheduleRepositoryImpl({required this.localDataSource});

  // --- (أ) عمليات "مجموعة المواعيد" ---

  @override
  Future<void> addScheduleGroup(ScheduleGroup group) async {
    // (7) بنحول الـ Entity النضيف لـ Model بيفهم داتابيز
    final groupModel = ScheduleGroupModel(
      id: group.id,
      name: group.name,
      hour: group.hour,
      minute: group.minute,
      daysOfWeek: group.daysOfWeek,
      isActive: group.isActive,
    );
    return await localDataSource.addScheduleGroup(groupModel);
  }

  @override
  Future<void> deleteScheduleGroup(int groupId) async {
    // (8) بنمرر الـ ID زي ما هو
    return await localDataSource.deleteScheduleGroup(groupId);
  }

  @override
  Future<List<ScheduleGroup>> getAllScheduleGroups() async {
    final groupModels = await localDataSource.getAllScheduleGroups();
    // (جديد) بنعمل قايمة جديدة صريحة
    return List<ScheduleGroup>.from(groupModels);
  }

  @override
  Future<void> updateScheduleGroup(ScheduleGroup group) async {
    // (7) زي الـ add، بنحول الـ Entity لـ Model
    final groupModel = ScheduleGroupModel(
      id: group.id,
      name: group.name,
      hour: group.hour,
      minute: group.minute,
      daysOfWeek: group.daysOfWeek,
      isActive: group.isActive,
    );
    return await localDataSource.updateScheduleGroup(groupModel);
  }

  // --- (ب) عمليات "الربط" ---

  @override
  Future<List<Medication>> getMedicationsForGroup(int groupId) async {
    final medicationModels = await localDataSource.getMedicationsForGroup(
      groupId,
    );
    // (جديد) بنعمل قايمة جديدة صريحة
    return List<Medication>.from(medicationModels);
  }

  @override
  Future<void> linkMedicationToGroup({
    required int groupId,
    required int medicationId,
  }) async {
    // (8) بنمرر الـ IDs زي ما هي
    return await localDataSource.linkMedicationToGroup(
      groupId: groupId,
      medicationId: medicationId,
    );
  }

  @override
  Future<void> unlinkMedicationFromGroup({
    required int groupId,
    required int medicationId,
  }) async {
    // (8) بنمرر الـ IDs زي ما هي
    return await localDataSource.unlinkMedicationFromGroup(
      groupId: groupId,
      medicationId: medicationId,
    );
  }
}
