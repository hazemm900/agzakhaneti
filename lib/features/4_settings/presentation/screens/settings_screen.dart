import 'package:agzakhaneti/app/core/localization/locale_cubit.dart';
import 'package:agzakhaneti/app/theme/theme_cubit.dart';
import 'package:agzakhaneti/features/4_settings/presentation/screens/help_screen.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/settings_section_header.dart';
import '../widgets/settings_section_card.dart';
import '../widgets/settings_options.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // --- 1. المظهر ---
          SettingsSectionHeader(
            title: l10n.settingsTheme,
            icon: Icons.palette_outlined,
          ),

          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, currentThemeMode) {
              return SettingsSectionCard(
                children: [
                  SettingsRadioOption<ThemeMode>(
                    title: l10n.settingsSystemTheme,
                    subtitle: l10n.settingsFollowDevice,
                    value: ThemeMode.system,
                    groupValue: currentThemeMode,
                    icon: Icons.smartphone_rounded,
                    onChanged: (val) =>
                        context.read<ThemeCubit>().changeTheme(val!),
                  ),
                  const SettingsDivider(),
                  SettingsRadioOption<ThemeMode>(
                    title: l10n.settingsLightTheme,
                    value: ThemeMode.light,
                    groupValue: currentThemeMode,
                    icon: Icons.wb_sunny_rounded,
                    onChanged: (val) =>
                        context.read<ThemeCubit>().changeTheme(val!),
                  ),
                  const SettingsDivider(),
                  SettingsRadioOption<ThemeMode>(
                    title: l10n.settingsDarkTheme,
                    value: ThemeMode.dark,
                    groupValue: currentThemeMode,
                    icon: Icons.nightlight_round,
                    onChanged: (val) =>
                        context.read<ThemeCubit>().changeTheme(val!),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),

          // --- 2. اللغة ---
          SettingsSectionHeader(
            title: l10n.settingsLanguage,
            icon: Icons.language_rounded,
          ),

          BlocBuilder<LocaleCubit, Locale?>(
            builder: (context, currentLocale) {
              final currentCode = currentLocale?.languageCode ?? 'system';

              return SettingsSectionCard(
                children: [
                  SettingsRadioOption<String>(
                    title: l10n.settingsSystemLanguage,
                    value: 'system',
                    groupValue: currentCode,
                    icon: Icons.settings_system_daydream_rounded,
                    onChanged: (val) =>
                        context.read<LocaleCubit>().changeLanguage('system'),
                  ),
                  const SettingsDivider(),
                  SettingsRadioOption<String>(
                    title: l10n.settingsArabic,
                    value: 'ar',
                    groupValue: currentCode,
                    icon: Icons.font_download_rounded,
                    onChanged: (val) =>
                        context.read<LocaleCubit>().changeLanguage('ar'),
                  ),
                  const SettingsDivider(),
                  SettingsRadioOption<String>(
                    title: l10n.settingsEnglish,
                    value: 'en',
                    groupValue: currentCode,
                    icon: Icons.abc_rounded,
                    onChanged: (val) =>
                        context.read<LocaleCubit>().changeLanguage('en'),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),

          // --- 3. قسم عن التطبيق (ممكن نعدله ونضيف المساعدة) ---
          SettingsSectionHeader(
            title: l10n.settingsHelp, // مترجم
            icon: Icons.help_outline_rounded,
          ),

          SettingsSectionCard(
            children: [
              SettingsSimpleTile(
                title: l10n.settingsAppTutorial, // مترجم
                icon: Icons.video_library_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HelpScreen()),
                  );
                },
              ),
              const SettingsDivider(),

              // ... باقي الأزرار (عن التطبيق، تواصل معنا)
              SettingsSimpleTile(
                title: l10n.settingsAboutApp,
                icon: Icons.info_outline_rounded,
                onTap: () {},
              ),
              const SettingsDivider(),
              SettingsSimpleTile(
                title: l10n.settingsContactUs,
                icon: Icons.mail_outline_rounded,
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 40),

          Center(
            child: Text(
              "Version 1.0.0",
              style: TextStyle(
                color: theme.colorScheme.onBackground.withOpacity(0.3),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
