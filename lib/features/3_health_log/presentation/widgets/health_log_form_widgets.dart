import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:agzakhaneti/app/utils/enums.dart';
import 'package:agzakhaneti/app/core/widgets/app_text_field.dart';
import 'package:agzakhaneti/app/core/widgets/app_dropdown.dart';

// --- 1. كارت اختيار النوع ---
class TypeSelectionCard extends StatelessWidget {
  final HealthReadingType type;
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;

  const TypeSelectionCard({
    super.key,
    required this.type,
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.15) : theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : theme.dividerColor.withOpacity(0.1),
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected
                  ? color
                  : theme.iconTheme.color?.withOpacity(0.5),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? color
                    : theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2. مدخلات الضغط (Blood Pressure Inputs) ---
class BloodPressureInputs extends StatelessWidget {
  final TextEditingController systolicController;
  final TextEditingController diastolicController;

  const BloodPressureInputs({
    super.key,
    required this.systolicController,
    required this.diastolicController,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      key: const ValueKey('BP'),
      children: [
        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: systolicController,
                label: l10n.systolicPressure,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                // استايل خاص للأرقام الكبيرة
                // (AppTextField might need customization or use TextFormField directly if needed)
                // هنا هنستخدم AppTextField بس ممكن نضيفله style parameter في المستقبل
                // للتسهيل هنستخدمه زي ما هو دلوقتي
                validator: (value) =>
                    value == null || value.isEmpty ? '' : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "/",
                style: TextStyle(
                  fontSize: 30,
                  color: theme.disabledColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Expanded(
              child: AppTextField(
                controller: diastolicController,
                label: l10n.diastolicPressure,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) =>
                    value == null || value.isEmpty ? '' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "Systolic (Top) / Diastolic (Bottom)",
          style: TextStyle(fontSize: 12, color: theme.disabledColor),
        ),
      ],
    );
  }
}

// --- 3. مدخلات السكر (Blood Sugar Inputs) ---
class BloodSugarInputs extends StatelessWidget {
  final TextEditingController levelController;
  final BloodSugarStatus? selectedStatus;
  final Function(BloodSugarStatus?) onStatusChanged;

  const BloodSugarInputs({
    super.key,
    required this.levelController,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      key: const ValueKey('BS'),
      children: [
        AppTextField(
          controller: levelController,
          label: l10n.bloodSugarLevel,
          suffixText: "mg/dL",
          prefixIcon: Icons.numbers_rounded,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
          ],
          validator: (value) =>
              value == null || value.isEmpty ? l10n.requiredField : null,
        ),

        AppDropdown<BloodSugarStatus>(
          value: selectedStatus,
          label: l10n.bloodSugarStatus,
          hint: l10n.chooseSugarStatusHint,
          prefixIcon: Icons.timelapse_rounded,
          items: BloodSugarStatus.values.map((status) {
            return DropdownMenuItem(
              value: status,
              child: Text(status.getDisplayName(context)),
            );
          }).toList(),
          onChanged: onStatusChanged,
          validator: (val) => val == null ? l10n.requiredField : null,
        ),
      ],
    );
  }
}
