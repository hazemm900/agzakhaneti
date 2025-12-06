import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:agzakhaneti/app/core/app_theme/app_colors.dart';
import '../../domain/entities/medication.dart'; // تأكد من المسار
import '../cubit/medication_cubit.dart';

class DoseConfirmDialog extends StatelessWidget {
  final Medication medication;

  const DoseConfirmDialog({super.key, required this.medication});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        l10n.confirmDose,
        style: TextStyle(color: colorScheme.onSurface),
      ),
      content: Text(
        l10n.tookDoseQuestion(medication.name, medication.doseValue.toString()),
        style: TextStyle(color: colorScheme.onSurface.withOpacity(0.8)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            l10n.cancel,
            style: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // تنفيذ اللوجيك
            context.read<MedicationCubit>().takeMedicationDose(medication);
            Navigator.pop(context);

            // إظهار رسالة نجاح
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: AppColors.secondaryGreen,
                content: Text(
                  l10n.doseTakenSuccess(medication.name),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(l10n.confirm),
        ),
      ],
    );
  }
}
