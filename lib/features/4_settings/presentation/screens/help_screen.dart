import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart'; // Import Localization
import 'package:agzakhaneti/app/core/widgets/app_section_header.dart';
import '../widgets/tutorial_video_card.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!; // الوصول للترجمة

    // ملاحظة: روابط اليوتيوب بتفضل ثابتة (هاردكود) لأنها مش نص بيترجم
    const String video1Url = "https://www.youtube.com/watch?v=YOUR_VIDEO_ID_1";
    const String video2Url = "https://www.youtube.com/watch?v=YOUR_VIDEO_ID_2";
    const String video3Url = "https://www.youtube.com/watch?v=YOUR_VIDEO_ID_3";

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(l10n.helpScreenTitle), // مترجم
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // --- القسم الأول: الجولة التعليمية ---
          AppSectionHeader(title: l10n.appTourSection), // مترجم

          Container(
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colorScheme.primary.withOpacity(0.3)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.touch_app_rounded,
                  color: colorScheme.primary,
                  size: 28,
                ),
              ),
              title: Text(
                l10n.resetTourTitle, // مترجم
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                l10n.resetTourSubtitle, // مترجم
                style: const TextStyle(fontSize: 12),
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('seen_med_tutorial', false);
                await prefs.setBool('seen_schedule_tutorial', false);
                await prefs.setBool('seen_link_tutorial', false);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.resetTourSuccess), // مترجم
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );

                  // الرجوع للصفحة الرئيسية
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
            ),
          ),

          const SizedBox(height: 30),

          // --- القسم الثاني: الفيديوهات ---
          AppSectionHeader(title: l10n.videoTutorialsSection), // مترجم

          TutorialVideoCard(
            videoTitle: l10n.videoAddMedicationTitle, // مترجم
            videoUrl: video1Url,
          ),

          TutorialVideoCard(
            videoTitle: l10n.videoScheduleTitle, // مترجم
            videoUrl: video2Url,
          ),

          TutorialVideoCard(
            videoTitle: l10n.videoHealthLogTitle, // مترجم
            videoUrl: video3Url,
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
