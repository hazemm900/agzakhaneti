import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:agzakhaneti/app/utils/enums.dart';
import '../../domain/entities/health_reading.dart';

class HealthReadingCard extends StatelessWidget {
  final HealthReading reading;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const HealthReadingCard({
    super.key,
    required this.reading,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    // تحديد الألوان والأيقونات بناءً على النوع
    final isBloodPressure = reading.type == HealthReadingType.bloodPressure;

    // الضغط: لون أحمر/وردي | السكر: لون أزرق/سماوي
    final primaryColor = isBloodPressure ? Colors.pinkAccent : Colors.cyan;
    final iconData = isBloodPressure
        ? Icons.favorite_rounded
        : Icons.water_drop_rounded;

    // تنسيق التاريخ (ديناميكي حسب لغة الجهاز)
    final locale = Localizations.localeOf(context).languageCode;
    final formattedDate = DateFormat(
      'dd MMM, yyyy',
      locale,
    ).format(reading.timestamp);
    final formattedTime = DateFormat(
      'hh:mm a',
      locale,
    ).format(reading.timestamp);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // الشريط الجانبي الملون
            Container(width: 6, color: primaryColor),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // الأيقونة في دائرة
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(iconData, color: primaryColor, size: 24),
                        ),
                        const SizedBox(width: 12),

                        // العناوين والقيم
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isBloodPressure
                                    ? l10n.healthLogBloodPressureTitle
                                    : l10n.healthLogBloodSugarTitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.6),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // القيمة بخط كبير وواضح (The Hero Value)
                              Text(
                                isBloodPressure
                                    ? '${reading.systolic}/${reading.diastolic}'
                                    : '${reading.sugarLevel} mg/dL',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              // تفاصيل إضافية (مثل: صائم / فاطر) للسكر
                              if (!isBloodPressure) ...[
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    _formatSugarStatus(
                                      reading.sugarStatus,
                                      l10n,
                                    ),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        // التاريخ والوقت
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.7,
                                ),
                              ),
                            ),
                            Text(
                              formattedTime,
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Divider(
                      color: theme.colorScheme.onSurface.withOpacity(0.05),
                    ),

                    // أزرار التحكم (تعديل وحذف)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildActionButton(
                          context,
                          icon: Icons.edit_rounded,
                          label: l10n.healthLogEditReading, // أو "Edit"
                          color: theme.colorScheme.primary,
                          onTap: onEdit,
                        ),
                        const SizedBox(width: 12),
                        _buildActionButton(
                          context,
                          icon: Icons.delete_rounded,
                          label: l10n.healthLogDeleteReading, // أو "Delete"
                          color: theme.colorScheme.error,
                          onTap: onDelete,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper لزر صغير وشيك
  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(icon, size: 16, color: color.withOpacity(0.8)),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color.withOpacity(0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatSugarStatus(BloodSugarStatus? status, AppLocalizations l10n) {
    switch (status) {
      case BloodSugarStatus.fasting:
        return l10n.bloodSugarFasting;
      case BloodSugarStatus.postMeal:
        return l10n.bloodSugarPostMeal;
      case BloodSugarStatus.random:
        return l10n.bloodSugarRandom;
      default:
        return '';
    }
  }
}
