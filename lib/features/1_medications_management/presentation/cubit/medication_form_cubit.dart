import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/medication.dart';
import '../../../../app/utils/enums.dart';
// بنستورد الكيوبت الكبير عشان نكلمه وقت الحفظ
import 'medication_cubit.dart';

// --- State ---
class MedicationFormState extends Equatable {
  final MedicationForm selectedForm;
  final DoseUnit derivedUnit;

  const MedicationFormState({
    this.selectedForm = MedicationForm.pill,
    this.derivedUnit = DoseUnit.pill,
  });

  MedicationFormState copyWith({
    MedicationForm? selectedForm,
    DoseUnit? derivedUnit,
  }) {
    return MedicationFormState(
      selectedForm: selectedForm ?? this.selectedForm,
      derivedUnit: derivedUnit ?? this.derivedUnit,
    );
  }

  @override
  List<Object> get props => [selectedForm, derivedUnit];
}

// --- Cubit ---
class MedicationFormCubit extends Cubit<MedicationFormState> {
  // الـ Controllers هنا عشان الصفحة تبقى Stateless
  final nameController = TextEditingController();
  final doseValueController = TextEditingController();
  final currentStockController = TextEditingController();
  final refillStockController = TextEditingController();
  final notesController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  MedicationFormCubit() : super(const MedicationFormState());

  // دالة التهيئة (لو بنعدل دواء موجود)
  void init(Medication? medicationToEdit) {
    if (medicationToEdit != null) {
      nameController.text = medicationToEdit.name;
      doseValueController.text = medicationToEdit.doseValue.toString();
      currentStockController.text = medicationToEdit.currentStock.toString();
      refillStockController.text = medicationToEdit.refillReminderStock
          .toString();
      notesController.text = medicationToEdit.notes ?? '';

      // تحديث الحالة (الشكل والوحدة)
      emit(
        state.copyWith(
          selectedForm: medicationToEdit.form,
          derivedUnit: medicationToEdit.doseUnit,
        ),
      );
    }
  }

  // لوجيك تغيير الشكل والوحدة (اللي كان في الصفحة زمان)
  void onFormChanged(MedicationForm? form) {
    if (form == null) return;

    DoseUnit newUnit;
    switch (form) {
      case MedicationForm.pill:
        newUnit = DoseUnit.pill;
        break;
      case MedicationForm.syrup:
        newUnit = DoseUnit.ml;
        break;
      case MedicationForm.injection:
        newUnit = DoseUnit.unit;
        break;
      case MedicationForm.inhaler:
        newUnit = DoseUnit.puff;
        break;
      case MedicationForm.drops:
        newUnit = DoseUnit.drop;
        break;
      case MedicationForm.cream:
        newUnit = DoseUnit.application;
        break;
      case MedicationForm.other:
        newUnit = DoseUnit.other;
    }

    emit(state.copyWith(selectedForm: form, derivedUnit: newUnit));
  }

  // دالة الحفظ: بتجمع الداتا وتكلم الكيوبت الكبير
  void submitForm(BuildContext context, {Medication? medicationToEdit}) {
    if (!formKey.currentState!.validate()) return;

    final isEditMode = medicationToEdit != null;

    final med = Medication(
      id: isEditMode ? medicationToEdit.id : null,
      name: nameController.text,
      form: state.selectedForm,
      doseValue: double.parse(doseValueController.text),
      doseUnit: state.derivedUnit,
      currentStock: double.parse(currentStockController.text),
      refillReminderStock: double.parse(refillStockController.text),
      notes: notesController.text.isEmpty ? null : notesController.text,
    );

    // 👇 هنا الربط! بنستخدم الكيوبت الكبير عشان يحفظ في الداتابيز
    if (isEditMode) {
      context.read<MedicationCubit>().updateExistingMedication(med);
    } else {
      context.read<MedicationCubit>().addNewMedication(med);
    }

    Navigator.pop(context);
  }

  // ميزة الكيوبت ده إنه بيقفل الـ Controllers أوتوماتيك لما الصفحة تتقفل
  @override
  Future<void> close() {
    nameController.dispose();
    doseValueController.dispose();
    currentStockController.dispose();
    refillStockController.dispose();
    notesController.dispose();
    return super.close();
  }
}
