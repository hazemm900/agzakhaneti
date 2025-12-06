import '../entities/health_reading.dart';
import '../repositories/health_repository.dart';

class GetAllHealthReadings {
  final HealthRepository repository;

  GetAllHealthReadings(this.repository);

  Future<List<HealthReading>> call() async {
    return await repository.getAllHealthReadings();
  }
}
