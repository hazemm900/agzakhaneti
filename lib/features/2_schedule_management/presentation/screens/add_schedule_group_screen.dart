import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:agzakhaneti/app/core/widgets/app_text_field.dart';
import 'package:agzakhaneti/app/core/widgets/app_section_header.dart';
import '../widgets/schedule_form_widgets.dart';
import '../../domain/entities/schedule_group.dart';
import '../cubit/schedule_form_cubit.dart';

class AddScheduleGroupScreen extends StatelessWidget {
  final ScheduleGroup? scheduleGroupToEdit;

  const AddScheduleGroupScreen({super.key, this.scheduleGroupToEdit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleFormCubit()..init(scheduleGroupToEdit),
      child: _AddScheduleFormBody(scheduleGroupToEdit: scheduleGroupToEdit),
    );
  }
}

class _AddScheduleFormBody extends StatelessWidget {
  final ScheduleGroup? scheduleGroupToEdit;

  const _AddScheduleFormBody({required this.scheduleGroupToEdit});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final formCubit = context.read<ScheduleFormCubit>();
    final isEditMode = scheduleGroupToEdit != null;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isEditMode ? t.editSchedule : t.addNewSchedule),
      ),
      body: BlocBuilder<ScheduleFormCubit, ScheduleFormState>(
        builder: (context, state) {
          return SafeArea(
            child: Form(
              key: formCubit.formKey,
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  // 1. الاسم
                  AppSectionHeader(title: t.scheduleName),
                  AppTextField(
                    controller: formCubit.nameController,
                    label: t.scheduleName,
                    hint: t.scheduleNameHint,
                    prefixIcon: Icons.label_outline_rounded,
                    validator: (val) => val == null || val.trim().isEmpty
                        ? t.requiredField
                        : null,
                  ),

                  const SizedBox(height: 10),

                  // 2. الوقت (استخدام الودجت المفصولة)
                  AppSectionHeader(title: t.pickTimeLabel),
                  TimePickerCard(
                    selectedTime: state.selectedTime,
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: state.selectedTime ?? TimeOfDay.now(),
                      );
                      if (time != null) {
                        formCubit.updateTime(time);
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  // 3. الأيام (استخدام الودجت المفصولة)
                  AppSectionHeader(title: t.repeatDays),
                  DaySelector(
                    selectedDays: state.selectedDays,
                    onDayToggled: formCubit.toggleDay,
                  ),

                  const SizedBox(height: 40),

                  // 4. زر الحفظ
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validation في الـ UI عشان نظهر SnackBar
                        if (state.selectedTime == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(t.chooseTimeError),
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.error,
                            ),
                          );
                          return;
                        }
                        if (state.selectedDays.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(t.chooseDayError),
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.error,
                            ),
                          );
                          return;
                        }

                        formCubit.submitForm(
                          context,
                          groupToEdit: scheduleGroupToEdit,
                        );
                      },
                      child: Text(
                        isEditMode ? t.saveChanges : t.saveSchedule,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
