import '../entities/medication.dart'; // (1) بنستورد الـ Entity بتاعنا

// (2) بنعرّف الكلاس كـ "abstract" يعني مجرد واجهة
abstract class MedicationRepository {
  // (3) دي العمليات اللي هنحتاجها للمحور الأول:

  /// دالة لجلب كل الأدوية المخزنة
  /// هترجع قايمة من الأدوية
  Future<List<Medication>> getAllMedications();

  /// دالة لإضافة دواء جديد
  /// هتاخد الدواء (من غير ID) وتخزنه
  Future<void> addMedication(Medication medication);

  /// دالة لتعديل دواء موجود (هنحتاجها عشان نعدل المخزون مثلاً)
  Future<void> updateMedication(Medication medication);

  /// دالة لحذف دواء (عن طريق الـ ID بتاعه)
  Future<void> deleteMedication(int id);
}
