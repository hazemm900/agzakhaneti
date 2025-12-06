import '../repositories/medication_repository.dart';

class DeleteMedication {
  final MedicationRepository repository;

  DeleteMedication(this.repository);

  // هنا بتاخد الـ ID بتاع الدواء اللي هيتحذف
  Future<void> call(int id) async {
    return await repository.deleteMedication(id);
  }
}
