import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:agzakhaneti/app/core/widgets/app_text_field.dart';

// --- 1. ويدجت صف الجرعة ---
class DoseRow extends StatelessWidget {
  final TextEditingController controller;
  final String unitText;

  const DoseRow({super.key, required this.controller, required this.unitText});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: AppTextField(
            controller: controller,
            label: l10n.dose,
            hint: "1, 2.5",
            prefixIcon: Icons.vaccines_outlined,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
            ],
            validator: (val) =>
                val == null || val.isEmpty ? l10n.requiredField : null,
          ),
        ),
        const SizedBox(width: 12),
        // حاوية عرض الوحدة
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: colorScheme.primary.withOpacity(0.2)),
          ),
          child: Text(
            unitText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

// --- 2. ويدجت صف المخزون ---
class StockRow extends StatelessWidget {
  final TextEditingController currentStockController;
  final TextEditingController refillStockController;

  const StockRow({
    super.key,
    required this.currentStockController,
    required this.refillStockController,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: AppTextField(
            controller: currentStockController,
            label: l10n.currentStock,
            prefixIcon: Icons.inventory_2_outlined,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
            ],
            validator: (val) =>
                val == null || val.isEmpty ? l10n.requiredField : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AppTextField(
            controller: refillStockController,
            label: "Alert Limit", // يفضل تستخدم l10n هنا برضه
            prefixIcon: Icons.notification_important_outlined,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
            ],
            validator: (val) =>
                val == null || val.isEmpty ? l10n.requiredField : null,
          ),
        ),
      ],
    );
  }
}
