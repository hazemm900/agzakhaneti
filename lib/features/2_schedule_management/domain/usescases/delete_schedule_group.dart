import '../repositories/schedule_repository.dart';

class DeleteScheduleGroup {
  final ScheduleRepository repository;

  DeleteScheduleGroup(this.repository);

  Future<void> call(int groupId) async {
    return await repository.deleteScheduleGroup(groupId);
  }
}
