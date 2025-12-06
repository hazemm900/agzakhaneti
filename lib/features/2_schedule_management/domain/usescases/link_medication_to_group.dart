import '../repositories/schedule_repository.dart';

class LinkMedicationToGroup {
  final ScheduleRepository repository;

  LinkMedicationToGroup(this.repository);

  // الـ UseCase ده محتاج الـ ID بتاع الاتنين
  Future<void> call({required int groupId, required int medicationId}) async {
    return await repository.linkMedicationToGroup(
      groupId: groupId,
      medicationId: medicationId,
    );
  }
}
