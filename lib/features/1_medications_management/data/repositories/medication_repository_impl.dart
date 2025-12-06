import '../../domain/entities/medication.dart'; // (1) ده الـ Entity
import '../../domain/repositories/medication_repository.dart'; // (2) ده الـ "عقد" اللي بننفذه
import '../datasources/medication_local_datasource.dart'; // (3) ده الـ DataSource اللي بيكلم الداتابيز
import '../models/medication_model.dart'; // (4) ده الـ Model اللي بنحول منه

// (5) بنعمل "implements" للـ "عقد" بتاعنا
class MedicationRepositoryImpl implements MedicationRepository {
  // (6) بنعتمد على الـ DataSource
  final MedicationLocalDataSource localDataSource;

  // (7) بنعمله "حقن" (Inject) في الـ Constructor
  MedicationRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addMedication(Medication medication) async {
    // الـ UseCase بيبعت "Medication" (Entity)
    // الـ DataSource عاوز "MedicationModel"
    // فـ إحنا بنحولها هنا
    final medicationModel = MedicationModel(
      id: medication.id,
      name: medication.name,
      form: medication.form,
      doseValue: medication.doseValue,
      doseUnit: medication.doseUnit,
      currentStock: medication.currentStock,
      refillReminderStock: medication.refillReminderStock,
      notes: medication.notes,
    );
    // بنبعت الـ Model للـ DataSource
    return await localDataSource.addMedication(medicationModel);
  }

  @override
  Future<void> deleteMedication(int id) async {
    // دي عملية بسيطة، بنمرر الـ ID زي ما هو
    return await localDataSource.deleteMedication(id);
  }

  @override
  Future<List<Medication>> getAllMedications() async {
    final medicationModels = await localDataSource.getAllMedications();
    // (جديد) بنعمل قايمة جديدة صريحة من النوع المطلوب
    return List<Medication>.from(medicationModels);
  }

  @override
  Future<void> updateMedication(Medication medication) async {
    // زي الـ add بالظبط، بنحول الـ Entity لـ Model
    final medicationModel = MedicationModel(
      id: medication.id,
      name: medication.name,
      form: medication.form,
      doseValue: medication.doseValue,
      doseUnit: medication.doseUnit,
      currentStock: medication.currentStock,
      refillReminderStock: medication.refillReminderStock,
      notes: medication.notes,
    );
    return await localDataSource.updateMedication(medicationModel);
  }
}
