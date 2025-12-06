import '../repositories/schedule_repository.dart';

class UnlinkMedicationFromGroup {
  final ScheduleRepository repository;

  UnlinkMedicationFromGroup(this.repository);

  Future<void> call({required int groupId, required int medicationId}) async {
    return await repository.unlinkMedicationFromGroup(
      groupId: groupId,
      medicationId: medicationId,
    );
  }
}
