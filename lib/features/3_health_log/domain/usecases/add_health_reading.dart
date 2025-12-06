import '../entities/health_reading.dart';
import '../repositories/health_repository.dart';

class AddHealthReading {
  final HealthRepository repository;

  AddHealthReading(this.repository);

  Future<void> call(HealthReading reading) async {
    return await repository.addHealthReading(reading);
  }
}
