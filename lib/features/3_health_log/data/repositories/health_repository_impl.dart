import '../../domain/entities/health_reading.dart';
import '../../domain/repositories/health_repository.dart';
import '../datasources/health_local_datasource.dart';
import '../models/health_reading_model.dart';

class HealthRepositoryImpl implements HealthRepository {
  final HealthLocalDataSource localDataSource;

  HealthRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addHealthReading(HealthReading reading) async {
    final readingModel = HealthReadingModel(
      id: reading.id,
      type: reading.type,
      timestamp: reading.timestamp,
      systolic: reading.systolic,
      diastolic: reading.diastolic,
      sugarLevel: reading.sugarLevel,
      sugarStatus: reading.sugarStatus,
      notes: reading.notes,
    );
    return await localDataSource.addHealthReading(readingModel);
  }

  @override
  Future<void> deleteHealthReading(int readingId) async {
    return await localDataSource.deleteHealthReading(readingId);
  }

  @override
  Future<List<HealthReading>> getAllHealthReadings() async {
    final readingModels = await localDataSource.getAllHealthReadings();
    return List<HealthReading>.from(readingModels);
  }

  // --- (جديد) (3) إضافة تنفيذ دالة التعديل ---
  @override
  Future<void> updateHealthReading(HealthReading reading) async {
    // (بنحول الـ Entity النضيف لـ Model بيفهم داتابيز)
    final readingModel = HealthReadingModel(
      id: reading.id, // (مهم جداً الـ ID هنا)
      type: reading.type,
      timestamp: reading.timestamp,
      systolic: reading.systolic,
      diastolic: reading.diastolic,
      sugarLevel: reading.sugarLevel,
      sugarStatus: reading.sugarStatus,
      notes: reading.notes,
    );
    // (بننادي الدالة اللي عملناها في الـ DataSource)
    return await localDataSource.updateHealthReading(readingModel);
  }
}
