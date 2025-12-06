import '../entities/schedule_group.dart';
import '../repositories/schedule_repository.dart';

class UpdateScheduleGroup {
  final ScheduleRepository repository;

  UpdateScheduleGroup(this.repository);

  Future<void> call(ScheduleGroup group) async {
    return await repository.updateScheduleGroup(group);
  }
}
