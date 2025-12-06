import '../entities/health_reading.dart';
import '../repositories/health_repository.dart';

class UpdateHealthReading {
  final HealthRepository repository;

  UpdateHealthReading(this.repository);

  // الـ UseCase ده بياخد "القراءة المُعدلة"
  Future<void> call(HealthReading reading) async {
    // وبينادي الدالة اللي لسه عاملينها في الـ Repository
    return await repository.updateHealthReading(reading);
  }
}
