import '../../../1_medications_management/domain/entities/medication.dart';
import '../repositories/schedule_repository.dart';

class GetMedicationsForGroup {
  final ScheduleRepository repository;

  GetMedicationsForGroup(this.repository);

  Future<List<Medication>> call(int groupId) async {
    return await repository.getMedicationsForGroup(groupId);
  }
}
