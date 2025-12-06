import '../entities/schedule_group.dart';
import '../repositories/schedule_repository.dart';

class GetAllScheduleGroups {
  final ScheduleRepository repository;

  GetAllScheduleGroups(this.repository);

  Future<List<ScheduleGroup>> call() async {
    return await repository.getAllScheduleGroups();
  }
}
