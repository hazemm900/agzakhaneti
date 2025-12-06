// (1) بنستورد الـ Bloc وأساسيات الـ State
import 'package:agzakhaneti/features/3_health_log/domain/usecases/update_health_reading.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// (2) بنستورد الـ Entity والـ UseCases
import '../../domain/entities/health_reading.dart';
import '../../domain/usecases/add_health_reading.dart';
import '../../domain/usecases/delete_health_reading.dart';
import '../../domain/usecases/get_all_health_readings.dart';

// (3) بنربط ملف الـ State (ده السطر اللي بيصلح الإيرور اللي كان هناك)
part 'health_log_state.dart';

class HealthLogCubit extends Cubit<HealthLogState> {
  // (1) بنعرّف الـ UseCases (بما فيهم الجديد)
  final GetAllHealthReadings getAllHealthReadings;
  final AddHealthReading addHealthReading;
  final DeleteHealthReading deleteHealthReading;
  final UpdateHealthReading updateHealthReading; // <-- (جديد)

  // (2) بنعملهم "حقن" (Inject) في الـ Constructor
  HealthLogCubit({
    required this.getAllHealthReadings,
    required this.addHealthReading,
    required this.deleteHealthReading,
    required this.updateHealthReading, // <-- (جديد)
  }) : super(HealthLogInitial());

  /// دالة لجلب كل القراءات الصحية (زي ما هي)
  Future<void> loadHealthReadings() async {
    try {
      emit(HealthLogLoading());
      final readings = await getAllHealthReadings();
      emit(HealthLogLoaded(readings));
    } catch (e) {
      emit(HealthLogError(e.toString()));
    }
  }

  /// دالة لإضافة قراءة جديدة (زي ما هي)
  Future<void> addNewHealthReading(HealthReading reading) async {
    try {
      await addHealthReading(reading);
      await loadHealthReadings();
    } catch (e) {
      emit(HealthLogError(e.toString()));
    }
  }

  /// دالة لحذف قراءة (زي ما هي)
  Future<void> deleteExistingHealthReading(int readingId) async {
    try {
      await deleteHealthReading(readingId);
      await loadHealthReadings();
    } catch (e) {
      emit(HealthLogError(e.toString()));
    }
  }

  // --- (جديد) (3) إضافة دالة التعديل ---
  Future<void> updateExistingHealthReading(HealthReading reading) async {
    try {
      // (بننادي الـ UseCase الجديد)
      await updateHealthReading(reading);
      // (بنحدث القايمة)
      await loadHealthReadings();
    } catch (e) {
      emit(HealthLogError(e.toString()));
    }
  }
}
