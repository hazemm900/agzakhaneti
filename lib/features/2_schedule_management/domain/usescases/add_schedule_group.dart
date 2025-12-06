import '../entities/schedule_group.dart';
import '../repositories/schedule_repository.dart';

class AddScheduleGroup {
  final ScheduleRepository repository;

  AddScheduleGroup(this.repository);

  Future<void> call(ScheduleGroup group) async {
    return await repository.addScheduleGroup(group);
  }
}
