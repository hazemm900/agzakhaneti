import 'package:flutter/material.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import '../../domain/entities/schedule_group.dart'; // تأكد من المسار

class ScheduleCard extends StatelessWidget {
  final ScheduleGroup scheduleGroup;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const ScheduleCard({
    super.key,
    required this.scheduleGroup,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 1. سحب الثيم والألوان
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // تنسيق الوقت (HH:mm)
    final timeString =
        '${scheduleGroup.hour.toString().padLeft(2, '0')}:${scheduleGroup.minute.toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface, // لون الكارت (أبيض/رمادي غامق)
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
        child: Row(
          children: [
            // --- الجزء الأيسر: أيقونة الوقت ---
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // لون خلفية بنفسجي/أزرق هادي يميز المواعيد
                color: Colors.deepPurpleAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.access_time_filled_rounded,
                color: Colors.deepPurpleAccent,
                size: 28,
              ),
            ),

            const SizedBox(width: 16),

            // --- الجزء الأوسط: الاسم والوقت ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scheduleGroup.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // عرض الوقت في شكل شيك
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      timeString,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- الجزء الأيمن: أزرار التحكم ---
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_rounded, size: 20),
                  color: colorScheme.onSurface.withOpacity(0.5),
                  onPressed: onEdit,
                  tooltip: AppLocalizations.of(context)!.editScheduleTooltip,
                ),
                IconButton(
                  icon: const Icon(Icons.delete_rounded, size: 20),
                  color: colorScheme.error.withOpacity(0.8),
                  onPressed: onDelete,
                  tooltip: AppLocalizations.of(context)!.deleteScheduleTooltip,
                ),
                // سهم صغير يدعوك للدخول للتفاصيل
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: colorScheme.onSurface.withOpacity(0.3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
