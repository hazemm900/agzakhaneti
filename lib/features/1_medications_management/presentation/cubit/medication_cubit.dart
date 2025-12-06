// (1) بنستورد الـ Bloc وأساسيات الـ State
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// (2) بنستورد الـ Entity والـ UseCases
import '../../domain/entities/medication.dart';
import '../../domain/usecases/add_medication.dart';
import '../../domain/usecases/delete_medication.dart';
import '../../domain/usecases/get_medications.dart';
import '../../domain/usecases/update_medication.dart';

// (3) بنربط ملف الـ State (ده السطر اللي بيصلح الإيرور اللي كان هناك)
part 'medication_state.dart';

class MedicationCubit extends Cubit<MedicationState> {
  // (4) بنعرّف الـ UseCases اللي الـ Cubit ده هيحتاجها
  final GetMedications getMedications;
  final AddMedication addMedication;
  final UpdateMedication updateMedication;
  final DeleteMedication deleteMedication;

  // (5) بنعملهم "حقن" (Inject) في الـ Constructor
  MedicationCubit({
    required this.getMedications,
    required this.addMedication,
    required this.updateMedication,
    required this.deleteMedication,
  }) : super(MedicationInitial()); // (6) بنبدأ بالحالة الابتدائية

  // --- (7) الدوال اللي الشاشة (UI) هتنادي عليها ---

  /// دالة لجلب كل الأدوية
  Future<void> loadMedications() async {
    try {
      emit(MedicationLoading());

      // (1) بنجيب الأدوية (زي ما هي)
      final medications = await getMedications();

      // (2) (جديد) بنحسب الأدوية اللي قربت تخلص
      int lowStockCount = 0;
      for (final med in medications) {
        // (ده الشرط اللي اتفقنا عليه: الحالي <= حد التنبيه)
        if (med.currentStock <= med.refillReminderStock) {
          lowStockCount++;
        }
      }

      // (3) (جديد) بنبعت القايمة "و" العدد
      emit(MedicationLoaded(medications, lowStockCount));
    } catch (e) {
      emit(MedicationError(e.toString()));
    }
  }

  /// دالة لإضافة دواء جديد
  Future<void> addNewMedication(Medication medication) async {
    try {
      // (ممكن نبعت حالة "جاري الإضافة" لو عاوزين، بس خلينا نبدأ بسيط)
      // emit(MedicationLoading());

      await addMedication(medication);

      // (الأهم) بعد ما نضيف الدوا، لازم نحدث القايمة
      // فـ بننادي الدالة اللي بتجيب كل الأدوية تاني
      await loadMedications();
    } catch (e) {
      emit(MedicationError(e.toString()));
    }
  }

  /// دالة لتعديل دواء (زي تحديث المخزون)
  Future<void> updateExistingMedication(Medication medication) async {
    try {
      await updateMedication(medication);
      // برضو بنحدث القايمة
      await loadMedications();
    } catch (e) {
      emit(MedicationError(e.toString()));
    }
  }

  /// دالة لحذف دواء
  Future<void> deleteExistingMedication(int id) async {
    try {
      await deleteMedication(id);
      // برضو بنحدث القايمة
      await loadMedications();
    } catch (e) {
      emit(MedicationError(e.toString()));
    }
  }

  /// (جديد) دالة لتسجيل أخذ الجرعة يدوياً
  Future<void> takeMedicationDose(Medication medication) async {
    try {
      // 1. بنحسب المخزون الجديد (الحالي - الجرعة)
      final newStock = medication.currentStock - medication.doseValue;

      // 2. بنعمل نسخة معدلة من الدواء
      final updatedMedication = medication.copyWith(currentStock: newStock);

      // 3. بنحدث في الداتابيز
      await updateMedication(updatedMedication);

      // 4. بنحدث القايمة عشان المستخدم يشوف الرقم اتغير
      await loadMedications();
    } catch (e) {
      emit(MedicationError(e.toString()));
    }
  }
}
