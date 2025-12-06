import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:agzakhaneti/app/utils/enums.dart';
import 'package:agzakhaneti/app/core/widgets/app_text_field.dart';
import '../widgets/health_log_form_widgets.dart';
import '../../domain/entities/health_reading.dart';
import '../cubit/health_log_form_cubit.dart';

class AddHealthReadingScreen extends StatelessWidget {
  final HealthReading? readingToEdit;

  const AddHealthReadingScreen({super.key, this.readingToEdit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HealthLogFormCubit()..init(readingToEdit),
      child: _AddHealthReadingFormBody(readingToEdit: readingToEdit),
    );
  }
}

class _AddHealthReadingFormBody extends StatelessWidget {
  final HealthReading? readingToEdit;

  const _AddHealthReadingFormBody({required this.readingToEdit});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final formCubit = context.read<HealthLogFormCubit>();
    final isEditMode = readingToEdit != null;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isEditMode ? l10n.editHealthReading : l10n.addNewReading),
      ),
      body: BlocBuilder<HealthLogFormCubit, HealthLogFormState>(
        builder: (context, state) {
          return SafeArea(
            child: Form(
              key: formCubit.formKey,
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  // 1. Type Selection
                  Text(
                    l10n.chooseReadingType,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: TypeSelectionCard(
                          type: HealthReadingType.bloodPressure,
                          label: "Blood Pressure",
                          icon: Icons.favorite_rounded,
                          color: Colors.pinkAccent,
                          isSelected:
                              state.selectedType ==
                              HealthReadingType.bloodPressure,
                          onTap: isEditMode
                              ? null
                              : () => formCubit.changeType(
                                  HealthReadingType.bloodPressure,
                                ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TypeSelectionCard(
                          type: HealthReadingType.bloodSugar,
                          label: "Blood Sugar",
                          icon: Icons.water_drop_rounded,
                          color: Colors.cyan,
                          isSelected:
                              state.selectedType ==
                              HealthReadingType.bloodSugar,
                          onTap: isEditMode
                              ? null
                              : () => formCubit.changeType(
                                  HealthReadingType.bloodSugar,
                                ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 2. Animated Form Fields
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: state.selectedType == HealthReadingType.bloodPressure
                        ? BloodPressureInputs(
                            systolicController: formCubit.systolicController,
                            diastolicController: formCubit.diastolicController,
                          )
                        : BloodSugarInputs(
                            levelController: formCubit.sugarLevelController,
                            selectedStatus: state.selectedSugarStatus,
                            onStatusChanged: formCubit.changeSugarStatus,
                          ),
                  ),

                  const SizedBox(height: 16),

                  // 3. Notes
                  AppTextField(
                    controller: formCubit.notesController,
                    label: l10n.notes,
                    prefixIcon: Icons.note_alt_outlined,
                    maxLines: 2,
                  ),

                  const SizedBox(height: 32),

                  // 4. Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        formCubit.submitForm(
                          context,
                          readingToEdit: readingToEdit,
                        );
                      },
                      child: Text(
                        isEditMode
                            ? l10n.saveHealthReadingEdits
                            : l10n.saveHealthReading,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
