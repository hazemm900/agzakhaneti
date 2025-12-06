import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/schedule_group.dart';
import 'schedule_cubit.dart'; // عشان نكلم الكيوبت الكبير

// --- State ---
class ScheduleFormState extends Equatable {
  final TimeOfDay? selectedTime;
  final Set<int> selectedDays; // بنستخدم Set عشان الأيام ممتكررش

  const ScheduleFormState({this.selectedTime, this.selectedDays = const {}});

  ScheduleFormState copyWith({
    TimeOfDay? selectedTime,
    Set<int>? selectedDays,
  }) {
    return ScheduleFormState(
      selectedTime: selectedTime ?? this.selectedTime,
      selectedDays: selectedDays ?? this.selectedDays,
    );
  }

  @override
  List<Object?> get props => [selectedTime, selectedDays];
}

// --- Cubit ---
class ScheduleFormCubit extends Cubit<ScheduleFormState> {
  final nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ScheduleFormCubit() : super(const ScheduleFormState());

  void init(ScheduleGroup? groupToEdit) {
    if (groupToEdit != null) {
      nameController.text = groupToEdit.name;
      emit(
        state.copyWith(
          selectedTime: TimeOfDay(
            hour: groupToEdit.hour,
            minute: groupToEdit.minute,
          ),
          selectedDays: Set.from(groupToEdit.daysOfWeek),
        ),
      );
    } else {
      // لو جديد، ممكن نخلي الوقت الافتراضي دلوقتي
      emit(state.copyWith(selectedTime: TimeOfDay.now()));
    }
  }

  void updateTime(TimeOfDay newTime) {
    emit(state.copyWith(selectedTime: newTime));
  }

  void toggleDay(int dayValue) {
    final currentDays = Set<int>.from(state.selectedDays);
    if (currentDays.contains(dayValue)) {
      currentDays.remove(dayValue);
    } else {
      currentDays.add(dayValue);
    }
    emit(state.copyWith(selectedDays: currentDays));
  }

  bool validate(BuildContext context) {
    // التحقق من الوقت والأيام (بما إنهم مش TextFields)
    if (state.selectedTime == null) {
      // إظهار رسالة خطأ (يفضل استخدام SnackBar في الـ UI Listener، بس للتسهيل هنا)
      return false;
    }
    if (state.selectedDays.isEmpty) {
      return false;
    }
    return formKey.currentState!.validate();
  }

  void submitForm(BuildContext context, {ScheduleGroup? groupToEdit}) {
    // بنعمل validation بسيط هنا، والرسائل هتطلع في الـ UI
    if (!formKey.currentState!.validate()) return;

    // (ملاحظة: التحقق من الوقت والأيام بيتم في الـ UI عشان نطلع SnackBar)

    final isEditMode = groupToEdit != null;

    final group = ScheduleGroup(
      id: isEditMode ? groupToEdit.id : null,
      name: nameController.text,
      hour: state.selectedTime!.hour,
      minute: state.selectedTime!.minute,
      daysOfWeek: state.selectedDays,
      isActive: isEditMode ? groupToEdit.isActive : true,
    );

    if (isEditMode) {
      context.read<ScheduleCubit>().updateExistingScheduleGroup(group);
    } else {
      context.read<ScheduleCubit>().addNewScheduleGroup(group);
    }

    Navigator.pop(context);
  }

  @override
  Future<void> close() {
    nameController.dispose();
    return super.close();
  }
}
