import '../entities/health_reading.dart';

abstract class HealthRepository {
  Future<List<HealthReading>> getAllHealthReadings();

  Future<void> addHealthReading(HealthReading reading);

  Future<void> deleteHealthReading(int readingId);

  Future<void> updateHealthReading(HealthReading reading); // <-- (جديد)
}
