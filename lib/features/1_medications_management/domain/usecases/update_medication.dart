import '../entities/medication.dart';
import '../repositories/medication_repository.dart';

class UpdateMedication {
  final MedicationRepository repository;

  UpdateMedication(this.repository);

  // زي الإضافة، بتاخد "الدواء" اللي هيتعدل
  Future<void> call(Medication medication) async {
    return await repository.updateMedication(medication);
  }
}
