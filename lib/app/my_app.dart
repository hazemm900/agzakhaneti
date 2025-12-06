import 'package:agzakhaneti/app/di/service_locator.dart';
import 'package:agzakhaneti/app/theme/theme_cubit.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/app_theme/app_theme.dart';
import 'core/localization/locale_cubit.dart';
import 'main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ThemeCubit>(),
      child: BlocProvider(
        create: (context) => sl<LocaleCubit>(),

        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return BlocBuilder<LocaleCubit, Locale?>(
              builder: (context, locale) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,

                  onGenerateTitle: (context) =>
                      AppLocalizations.of(context)!.appTitle,

                  locale: locale,
                  supportedLocales: const [Locale('ar'), Locale('en')],
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],

                  localeResolutionCallback: (deviceLocale, supportedLocales) {
                    for (var locale in supportedLocales) {
                      if (locale.languageCode == deviceLocale?.languageCode) {
                        return locale;
                      }
                    }
                    return supportedLocales.first;
                  },

                  themeMode: themeMode,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,

                  home: const MainScreen(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
