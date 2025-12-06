import 'package:agzakhaneti/app/core/localization/locale_cubit.dart';
import 'package:agzakhaneti/app/theme/theme_cubit.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/add_schedule_group.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/delete_schedule_group.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/get_all_schedule_groups.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/get_medications_for_group.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/link_medication_to_group.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/unlink_medication_from_group.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/update_schedule_group.dart';
import 'package:agzakhaneti/features/3_health_log/domain/usecases/update_health_reading.dart';
import 'package:get_it/get_it.dart';
import '../services/database_service.dart';
import '../services/notification_service.dart';

// --- (Imports) Feature 1: Medications Management ---
import '../../features/1_medications_management/data/datasources/medication_local_datasource.dart';
import '../../features/1_medications_management/data/repositories/medication_repository_impl.dart';
import '../../features/1_medications_management/domain/repositories/medication_repository.dart';
import '../../features/1_medications_management/domain/usecases/add_medication.dart';
import '../../features/1_medications_management/domain/usecases/delete_medication.dart';
import '../../features/1_medications_management/domain/usecases/get_medications.dart';
import '../../features/1_medications_management/domain/usecases/update_medication.dart';
import '../../features/1_medications_management/presentation/cubit/medication_cubit.dart';

// --- (Imports) Feature 2: Schedule Management ---
import '../../features/2_schedule_management/data/datasources/schedule_local_datasource.dart';
import '../../features/2_schedule_management/data/repositories/schedule_repository_impl.dart';
import '../../features/2_schedule_management/domain/repositories/schedule_repository.dart';
import '../../features/2_schedule_management/presentation/cubit/schedule_cubit.dart';

// --- (Imports) Feature 3: Health Log ---
// Data Layer
import '../../features/3_health_log/data/datasources/health_local_datasource.dart';
import '../../features/3_health_log/data/repositories/health_repository_impl.dart';
// Domain Layer
import '../../features/3_health_log/domain/repositories/health_repository.dart';
import '../../features/3_health_log/domain/usecases/add_health_reading.dart';
import '../../features/3_health_log/domain/usecases/delete_health_reading.dart';
import '../../features/3_health_log/domain/usecases/get_all_health_readings.dart';
// (جديد) --- نستورد الـ Cubit ---
import '../../features/3_health_log/presentation/cubit/health_log_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // --- Services ---
  sl.registerLazySingleton<DatabaseService>(() => DatabaseService());
  sl.registerLazySingleton<NotificationService>(() => NotificationService());
  sl.registerLazySingleton(() => ThemeCubit());
  sl.registerLazySingleton(() => LocaleCubit());

  // --- تسجيل كل ما يخص Feature 1 (Medications Management) ---
  // (زي ما هو)
  sl.registerLazySingleton<MedicationLocalDataSource>(
    () => MedicationLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<MedicationRepository>(
    () => MedicationRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetMedications(sl()));
  sl.registerLazySingleton(() => AddMedication(sl()));
  sl.registerLazySingleton(() => UpdateMedication(sl()));
  sl.registerLazySingleton(() => DeleteMedication(sl()));
  sl.registerFactory(
    () => MedicationCubit(
      getMedications: sl(),
      addMedication: sl(),
      updateMedication: sl(),
      deleteMedication: sl(),
    ),
  );

  // --- تسجيل كل ما يخص Feature 2 (Schedule Management) ---
  // (زي ما هو)
  sl.registerLazySingleton<ScheduleLocalDataSource>(
    () => ScheduleLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetAllScheduleGroups(sl()));
  sl.registerLazySingleton(() => AddScheduleGroup(sl()));
  sl.registerLazySingleton(() => UpdateScheduleGroup(sl()));
  sl.registerLazySingleton(() => DeleteScheduleGroup(sl()));
  sl.registerLazySingleton(() => GetMedicationsForGroup(sl()));
  sl.registerLazySingleton(() => LinkMedicationToGroup(sl()));
  sl.registerLazySingleton(() => UnlinkMedicationFromGroup(sl()));
  sl.registerFactory(
    () => ScheduleCubit(
      notificationService: sl(),
      getAllScheduleGroups: sl(),
      addScheduleGroup: sl(),
      updateScheduleGroup: sl(),
      deleteScheduleGroup: sl(),
    ),
  );

  // --- (جديد) تسجيل كل ما يخص Feature 3 (Health Log) ---

  // أ) DataSources
  sl.registerLazySingleton<HealthLocalDataSource>(
    () => HealthLocalDataSourceImpl(),
  );

  // ب) Repositories
  sl.registerLazySingleton<HealthRepository>(
    () => HealthRepositoryImpl(localDataSource: sl()),
  );

  // ج) UseCases (الـ 3 كلهم)
  sl.registerLazySingleton(() => GetAllHealthReadings(sl()));
  sl.registerLazySingleton(() => AddHealthReading(sl()));
  sl.registerLazySingleton(() => DeleteHealthReading(sl()));
  sl.registerLazySingleton(() => UpdateHealthReading(sl()));

  // (جديد) --- د) تسجيل الـ Cubit ---
  // (برضو بنسجله كـ "Factory")
  sl.registerFactory(
    () => HealthLogCubit(
      // (بنطلب الـ UseCases اللي الـ Cubit ده محتاجها)
      getAllHealthReadings: sl(),
      addHealthReading: sl(),
      deleteHealthReading: sl(),
      updateHealthReading: sl(),
    ),
  );
}
