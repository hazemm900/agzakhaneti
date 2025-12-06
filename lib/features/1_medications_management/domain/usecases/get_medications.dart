import '../entities/medication.dart';
import '../repositories/medication_repository.dart';

class GetMedications {
  // (1) بيعتمد على الـ "عقد" (Repository)
  final MedicationRepository repository;

  // (2) بنعمله "حقن" (Inject) عن طريق الـ Constructor
  GetMedications(this.repository);

  // (3) الدالة `call` هي اللي بتنفذ المهمة المطلوبة
  // دي بتخلينا ننادي الكلاس ده كأنه دالة
  Future<List<Medication>> call() async {
    // كل اللي بيعمله إنه بينادي الدالة اللي في الـ repository
    return await repository.getAllMedications();
  }
}
