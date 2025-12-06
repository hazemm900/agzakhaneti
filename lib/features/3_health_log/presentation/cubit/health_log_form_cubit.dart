import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/health_reading.dart';
import '../../../../app/utils/enums.dart';
import 'health_log_cubit.dart';

// --- State ---
class HealthLogFormState extends Equatable {
  final HealthReadingType selectedType;
  final BloodSugarStatus? selectedSugarStatus;

  const HealthLogFormState({
    this.selectedType = HealthReadingType.bloodPressure,
    this.selectedSugarStatus,
  });

  HealthLogFormState copyWith({
    HealthReadingType? selectedType,
    BloodSugarStatus? selectedSugarStatus,
  }) {
    return HealthLogFormState(
      selectedType: selectedType ?? this.selectedType,
      selectedSugarStatus: selectedSugarStatus ?? this.selectedSugarStatus,
    );
  }

  @override
  List<Object?> get props => [selectedType, selectedSugarStatus];
}

// --- Cubit ---
class HealthLogFormCubit extends Cubit<HealthLogFormState> {
  // Controllers
  final systolicController = TextEditingController();
  final diastolicController = TextEditingController();
  final sugarLevelController = TextEditingController();
  final notesController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  HealthLogFormCubit() : super(const HealthLogFormState());

  void init(HealthReading? readingToEdit) {
    if (readingToEdit != null) {
      notesController.text = readingToEdit.notes ?? '';

      // نملأ البيانات حسب النوع
      if (readingToEdit.type == HealthReadingType.bloodPressure) {
        systolicController.text = readingToEdit.systolic.toString();
        diastolicController.text = readingToEdit.diastolic.toString();
      } else {
        sugarLevelController.text = readingToEdit.sugarLevel.toString();
      }

      emit(
        state.copyWith(
          selectedType: readingToEdit.type,
          selectedSugarStatus: readingToEdit.sugarStatus,
        ),
      );
    }
  }

  void changeType(HealthReadingType type) {
    emit(state.copyWith(selectedType: type));
  }

  void changeSugarStatus(BloodSugarStatus? status) {
    emit(state.copyWith(selectedSugarStatus: status));
  }

  void submitForm(BuildContext context, {HealthReading? readingToEdit}) {
    if (!formKey.currentState!.validate()) return;

    final sys = state.selectedType == HealthReadingType.bloodPressure
        ? int.tryParse(systolicController.text)
        : null;
    final dia = state.selectedType == HealthReadingType.bloodPressure
        ? int.tryParse(diastolicController.text)
        : null;
    final sugar = state.selectedType == HealthReadingType.bloodSugar
        ? double.tryParse(sugarLevelController.text)
        : null;

    // التأكد من إن الحالة موجودة لو النوع سكر
    final status = state.selectedType == HealthReadingType.bloodSugar
        ? state.selectedSugarStatus
        : null;

    final isEditMode = readingToEdit != null;
    final timestamp = isEditMode ? readingToEdit.timestamp : DateTime.now();

    final reading = HealthReading(
      id: isEditMode ? readingToEdit.id : null,
      type: state.selectedType,
      timestamp: timestamp,
      systolic: sys,
      diastolic: dia,
      sugarLevel: sugar,
      sugarStatus: status,
      notes: notesController.text.isEmpty ? null : notesController.text,
    );

    if (isEditMode) {
      context.read<HealthLogCubit>().updateExistingHealthReading(reading);
    } else {
      context.read<HealthLogCubit>().addNewHealthReading(reading);
    }

    Navigator.pop(context);
  }

  @override
  Future<void> close() {
    systolicController.dispose();
    diastolicController.dispose();
    sugarLevelController.dispose();
    notesController.dispose();
    return super.close();
  }
}
