import '../entities/medication.dart';
import '../repositories/medication_repository.dart';

class AddMedication {
  final MedicationRepository repository;

  AddMedication(this.repository);

  // المرة دي، دالة `call` بتاخد باراميتر وهو "الدواء"
  Future<void> call(Medication medication) async {
    return await repository.addMedication(medication);
  }
}
