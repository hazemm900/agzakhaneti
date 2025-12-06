// (1) بنستورد الـ Bloc وأساسيات الـ State
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/get_medications_for_group.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/link_medication_to_group.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/unlink_medication_from_group.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// (2) بنستورد الـ Entities والـ UseCases
import '../../../1_medications_management/domain/entities/medication.dart';
import '../../domain/entities/schedule_group.dart';

// (3) بنربط ملف الـ State (ده السطر اللي بيصلح الإيرور اللي كان هناك)
part 'schedule_detail_state.dart';

class ScheduleDetailCubit extends Cubit<ScheduleDetailState> {
  // (4) بنعرّف الـ UseCases اللي الـ Cubit ده هيحتاجها
  final GetMedicationsForGroup getMedicationsForGroup;
  final LinkMedicationToGroup linkMedicationToGroup;
  final UnlinkMedicationFromGroup unlinkMedicationFromGroup;

  // (5) (مهم) الـ Cubit ده محتاج يعرف هو شغال على أنهي "مجموعة"
  final ScheduleGroup scheduleGroup;

  // (6) بنعملهم "حقن" (Inject) في الـ Constructor
  ScheduleDetailCubit({
    required this.getMedicationsForGroup,
    required this.linkMedicationToGroup,
    required this.unlinkMedicationFromGroup,
    required this.scheduleGroup, // (لازم نمرر له المجموعة اللي هيشتغل عليها)
  }) : super(ScheduleDetailInitial()); // (7) بنبدأ بالحالة الابتدائية

  // --- (8) الدوال اللي الشاشة (UI) هتنادي عليها ---

  /// دالة لجلب الأدوية المرتبطة بالمجموعة دي (اللي في scheduleGroup.id)
  Future<void> loadLinkedMedications() async {
    try {
      emit(ScheduleDetailLoading());

      // بنكلم الـ UseCase ونبعتله الـ ID بتاع المجموعة بتاعتنا
      final medications = await getMedicationsForGroup(scheduleGroup.id!);

      emit(ScheduleDetailLoaded(medications));
    } catch (e) {
      emit(ScheduleDetailError(e.toString()));
    }
  }

  /// دالة لربط دواء جديد بالمجموعة دي
  Future<void> linkMedication(int medicationId) async {
    try {
      await linkMedicationToGroup(
        groupId: scheduleGroup.id!,
        medicationId: medicationId,
      );

      // (الأهم) بعد ما نربط، لازم نحدث القايمة
      await loadLinkedMedications();
    } catch (e) {
      emit(ScheduleDetailError(e.toString()));
    }
  }

  /// دالة لفك ربط دواء من المجموعة دي
  Future<void> unlinkMedication(int medicationId) async {
    try {
      await unlinkMedicationFromGroup(
        groupId: scheduleGroup.id!,
        medicationId: medicationId,
      );
      // برضو بنحدث القايمة
      await loadLinkedMedications();
    } catch (e) {
      emit(ScheduleDetailError(e.toString()));
    }
  }
}
