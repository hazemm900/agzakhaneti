import 'package:agzakhaneti/app/core/widgets/app_dropdown.dart';
import 'package:agzakhaneti/app/core/widgets/app_section_header.dart';
import 'package:agzakhaneti/app/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:agzakhaneti/app/utils/enums.dart';

import '../widgets/add_medication_form_sections.dart';

import '../../domain/entities/medication.dart';
import '../cubit/medication_form_cubit.dart';

class AddMedicationScreen extends StatelessWidget {
  final Medication? medicationToEdit;

  const AddMedicationScreen({super.key, this.medicationToEdit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicationFormCubit()..init(medicationToEdit),
      child: _AddMedicationFormBody(medicationToEdit: medicationToEdit),
    );
  }
}

class _AddMedicationFormBody extends StatelessWidget {
  final Medication? medicationToEdit;

  const _AddMedicationFormBody({required this.medicationToEdit});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final formCubit = context.read<MedicationFormCubit>();
    final isEditMode = medicationToEdit != null;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isEditMode ? l10n.editMedication : l10n.addMedication),
      ),
      body: BlocBuilder<MedicationFormCubit, MedicationFormState>(
        builder: (context, state) {
          return SafeArea(
            child: Form(
              key: formCubit.formKey,
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  // 1. الاسم والشكل
                  AppSectionHeader(title: l10n.medicineName),
                  AppTextField(
                    controller: formCubit.nameController,
                    label: l10n.medicineName,
                    prefixIcon: Icons.medication_outlined,
                    validator: (val) =>
                        val == null || val.isEmpty ? l10n.requiredField : null,
                  ),

                  AppDropdown<MedicationForm>(
                    value: state.selectedForm,
                    label: l10n.medicineShape,
                    hint: l10n.chooseMedicineShape,
                    prefixIcon: Icons.category_outlined,
                    items: MedicationForm.values.map((form) {
                      return DropdownMenuItem(
                        value: form,
                        child: Text(form.getDisplayName(context)),
                      );
                    }).toList(),
                    onChanged: formCubit.onFormChanged,
                    validator: (val) => val == null ? l10n.requiredField : null,
                  ),

                  const SizedBox(height: 10),

                  // 2. الجرعة (استخدام الودجت المفصولة)
                  AppSectionHeader(title: l10n.dose),
                  DoseRow(
                    controller: formCubit.doseValueController,
                    unitText: state.derivedUnit.getDisplayName(context),
                  ),

                  const SizedBox(height: 10),

                  // 3. المخزون (استخدام الودجت المفصولة)
                  AppSectionHeader(title: l10n.currentStock),
                  StockRow(
                    currentStockController: formCubit.currentStockController,
                    refillStockController: formCubit.refillStockController,
                  ),

                  const SizedBox(height: 10),

                  // 4. الملاحظات
                  AppSectionHeader(title: l10n.notes),
                  AppTextField(
                    controller: formCubit.notesController,
                    label: l10n.notes,
                    prefixIcon: Icons.note_alt_outlined,
                    maxLines: 3,
                  ),

                  const SizedBox(height: 30),

                  // زر الحفظ
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        formCubit.submitForm(
                          context,
                          medicationToEdit: medicationToEdit,
                        );
                      },
                      child: Text(
                        isEditMode ? l10n.saveEdits : l10n.saveMedicine,
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
