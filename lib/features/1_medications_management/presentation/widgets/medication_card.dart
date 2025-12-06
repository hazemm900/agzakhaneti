import 'package:agzakhaneti/app/core/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import '../../domain/entities/medication.dart';

class MedicationCard extends StatefulWidget {
  final Medication medication;
  final VoidCallback onTakeDose;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MedicationCard({
    super.key,
    required this.medication,
    required this.onTakeDose,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<MedicationCard> createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // (1) نسحب الثيم والألوان
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final unitName = widget.medication.doseUnit.toString().split('.').last;
    final formName = widget.medication.form.toString().split('.').last;

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          // (2) لون الكارت من الـ Surface (أبيض في الفاتح / رمادي غامق في الغامق)
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              // (3) الظل: أسود خفيف في الدارك مود، ورمادي في اللايت مود
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: _isExpanded ? 15 : 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: _isExpanded
              ? Border.all(
                  color: colorScheme.primary.withOpacity(0.3),
                  width: 1,
                )
              : null,
        ),
        child: Column(
          children: [
            // --- الجزء العلوي ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.medication_rounded,
                      color: colorScheme.primary, // اللون الأساسي (أزرق)
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.medication.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            // (4) لون النص الأساسي (أسود/أبيض)
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 14,
                              color: colorScheme.onSurface.withOpacity(0.6),
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                '${AppLocalizations.of(context)!.currentStock}: ${widget.medication.currentStock} $unitName',
                                style: TextStyle(
                                  fontSize: 14,
                                  // (5) لون النص الفرعي (رمادي مناسب للوضعين)
                                  color: colorScheme.onSurface.withOpacity(0.6),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: colorScheme.onSurface.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),

            // --- الجزء المخفي ---
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Container(
                height: _isExpanded ? null : 0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Divider(color: colorScheme.onSurface.withOpacity(0.1)),
                    const SizedBox(height: 10),

                    _buildDetailRow(
                      context,
                      icon: Icons.monitor_weight_outlined,
                      label: AppLocalizations.of(context)!.dose,
                      value:
                          '${widget.medication.doseValue} $unitName ($formName)',
                    ),

                    const SizedBox(height: 10),

                    _buildDetailRow(
                      context,
                      icon: Icons.notification_important_outlined,
                      label: "Refill Alert at",
                      value:
                          '${widget.medication.refillReminderStock} $unitName',
                    ),

                    if (widget.medication.notes != null &&
                        widget.medication.notes!.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          // لون الملاحظات (Amber) بيمشي مع الاتنين بس بنظبط الشفافية
                          color: Colors.amber.withOpacity(isDark ? 0.15 : 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.sticky_note_2_outlined,
                              size: 18,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.medication.notes!,
                                style: TextStyle(
                                  // النص يبقى واضح في الدارك واللايت
                                  color: isDark
                                      ? Colors.amber[200]
                                      : Colors.amber[900],
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // --- الأزرار ---
            if (_isExpanded)
              Divider(
                height: 1,
                color: colorScheme.onSurface.withOpacity(0.05),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_rounded, size: 20),
                    color: colorScheme.onSurface.withOpacity(0.5),
                    onPressed: widget.onEdit,
                    tooltip: AppLocalizations.of(context)!.editMedication,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_rounded, size: 20),
                    color: colorScheme.error.withOpacity(
                      0.8,
                    ), // لون الخطأ (أحمر)
                    onPressed: widget.onDelete,
                    tooltip: AppLocalizations.of(context)!.deleteMedication,
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: widget.onTakeDose,
                    style: TextButton.styleFrom(
                      foregroundColor:
                          AppColors.secondaryGreen, // الأخضر بتاعنا
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      backgroundColor: AppColors.secondaryGreen.withOpacity(
                        0.1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.check_circle_outline),
                    label: Text(
                      AppLocalizations.of(context)!.takeDose,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    // Helper يستخدم الثيم برضه
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 18, color: colorScheme.onSurface.withOpacity(0.4)),
        const SizedBox(width: 8),
        Text(
          "$label: ",
          style: TextStyle(
            color: colorScheme.onSurface.withOpacity(0.6),
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: colorScheme.onSurface, // أسود أو أبيض
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
