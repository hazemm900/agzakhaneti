import 'package:flutter/material.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:agzakhaneti/features/1_medications_management/domain/entities/medication.dart';

class LinkedMedicationCard extends StatelessWidget {
  final Medication medication;
  final VoidCallback onUnlink;

  const LinkedMedicationCard({
    super.key,
    required this.medication,
    required this.onUnlink,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    // استخراج اسم الوحدة
    final unitName = medication.doseUnit.toString().split('.').last;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        // بوردر خفيف عشان يبان إنه "مربوط"
        border: Border.all(color: colorScheme.primary.withOpacity(0.1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(
              0.1,
            ), // أخضر عشان ده دواء "مربوط" وتمام
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle_outline, color: Colors.green),
        ),
        title: Text(
          medication.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              Icon(
                Icons.vaccines_outlined,
                size: 14,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 4),
              Text(
                '${medication.doseValue} $unitName',
                style: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.link_off_rounded,
            color: colorScheme.error.withOpacity(0.7),
          ),
          tooltip: l10n.unlinkMedicationTooltip,
          onPressed: onUnlink,
        ),
      ),
    );
  }
}
