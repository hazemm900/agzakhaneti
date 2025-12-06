import '../repositories/health_repository.dart';

class DeleteHealthReading {
  final HealthRepository repository;

  DeleteHealthReading(this.repository);

  Future<void> call(int readingId) async {
    return await repository.deleteHealthReading(readingId);
  }
}
