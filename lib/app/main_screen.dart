import 'package:agzakhaneti/app/di/service_locator.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/1_medications_management/presentation/cubit/medication_cubit.dart';
import '../features/2_schedule_management/presentation/cubit/schedule_cubit.dart';
import '../features/3_health_log/presentation/cubit/health_log_cubit.dart';
import '../features/1_medications_management/presentation/screens/medications_list_screen.dart';
import '../features/2_schedule_management/presentation/screens/schedule_list_screen.dart';
import '../features/3_health_log/presentation/screens/health_log_screen.dart';
import '../features/4_settings/presentation/screens/settings_screen.dart';
import '../features/1_medications_management/presentation/screens/add_medication_screen.dart';
import '../features/2_schedule_management/presentation/screens/add_schedule_group_screen.dart';
import '../features/3_health_log/presentation/screens/add_health_reading_screen.dart';
import '../features/5_notifications/presentation/screens/notifications_screen.dart';

// ... (نفس الـ Imports)

// 1. الغلاف (زي ما هو)
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: (context) {
        // الـ Context ده هو اللي شايل الـ ShowCase
        return const MainContent();
      },
    );
  }
}

// 2. المحتوى
class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  int _currentIndex = 0;

  final GlobalKey _addMedicationFabKey = GlobalKey();
  final GlobalKey _addScheduleFabKey = GlobalKey();

  late final MedicationCubit _medicationCubit;
  late final ScheduleCubit _scheduleCubit;
  late final HealthLogCubit _healthLogCubit;

  final List<Widget> _screens = [
    const MedicationsListScreen(),
    const ScheduleListScreen(),
    const HealthLogScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _medicationCubit = sl<MedicationCubit>()..loadMedications();
    _scheduleCubit = sl<ScheduleCubit>()..loadScheduleGroups();
    _healthLogCubit = sl<HealthLogCubit>()..loadHealthReadings();

    // 👇 التغيير هنا: تأكد إننا بنستدعي الـ ShowCase بعد البناء بالكامل
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // بنستخدم الـ context بتاع الـ State اللي هو ابن للـ ShowCaseWidget
      if (mounted) {
        _checkAndShowMedicationShowcase();
      }
    });
  }

  Future<void> _checkAndShowMedicationShowcase() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenMedTutorial = prefs.getBool('seen_med_tutorial') ?? false;

    if (!hasSeenMedTutorial) {
      if (mounted) {
        // 👇 هنا كان الخطأ، دلوقتي الـ context ده سليم لأنه تحت الـ Wrapper
        try {
          ShowCaseWidget.of(context).startShowCase([_addMedicationFabKey]);
          await prefs.setBool('seen_med_tutorial', true);
        } catch (e) {
          debugPrint("Showcase Error: $e"); // عشان لو حصل خطأ ميكراشش التطبيق
        }
      }
    }
  }

  Future<void> _checkAndShowScheduleShowcase() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenScheduleTutorial =
        prefs.getBool('seen_schedule_tutorial') ?? false;

    if (!hasSeenScheduleTutorial) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        ShowCaseWidget.of(context).startShowCase([_addScheduleFabKey]);
        await prefs.setBool('seen_schedule_tutorial', true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _medicationCubit),
        BlocProvider.value(value: _scheduleCubit),
        BlocProvider.value(value: _healthLogCubit),
      ],
      child: Builder(
        builder: (innerContext) {
          return Scaffold(
            appBar: AppBar(
              title: _buildAppBarTitle(_currentIndex),
              centerTitle: true,
              scrolledUnderElevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              actions: [_buildNotificationBell(innerContext)],
            ),

            body: IndexedStack(index: _currentIndex, children: _screens),

            floatingActionButton: _buildAnimatedFAB(innerContext),

            bottomNavigationBar: NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });

                if (index == 0) {
                  _checkAndShowMedicationShowcase();
                }
                if (index == 1) {
                  _checkAndShowScheduleShowcase();
                }
              },
              // elevation: 2,
              // height: 70,
              //              indicatorColor: colorScheme.primary.withOpacity(0.15),
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.medication_outlined),
                  selectedIcon: const Icon(Icons.medication_rounded),
                  label: AppLocalizations.of(context)!.myMedications,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.schedule_outlined),
                  selectedIcon: const Icon(Icons.schedule_rounded),
                  label: AppLocalizations.of(context)!.mySchedule,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.bar_chart_rounded),
                  selectedIcon: const Icon(Icons.show_chart_rounded),
                  label: AppLocalizations.of(context)!.healthLog,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings_rounded),
                  label: AppLocalizations.of(context)!.settings,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBarTitle(int index) {
    final style = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    switch (index) {
      case 0:
        return Text(AppLocalizations.of(context)!.myMedications, style: style);
      case 1:
        return Text(AppLocalizations.of(context)!.mySchedule, style: style);
      case 2:
        return Text(AppLocalizations.of(context)!.healthLog, style: style);
      case 3:
        return Text(AppLocalizations.of(context)!.settings, style: style);
      default:
        return Text(AppLocalizations.of(context)!.appTitle, style: style);
    }
  }

  Widget _buildAnimatedFAB(BuildContext context) {
    final showFab = _currentIndex != 3;

    return AnimatedScale(
      scale: showFab ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutBack,
      child: showFab
          ? _buildContextualFAB(context, _currentIndex)
          : const SizedBox(),
    );
  }

  Widget _buildContextualFAB(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context)!; // الوصول للترجمة

    switch (index) {
      case 0: // صفحة الأدوية
        return Showcase(
          key: _addMedicationFabKey,
          title: l10n.showcaseAddMedTitle, // مترجم
          description: l10n.showcaseAddMedDesc, // مترجم
          overlayColor: Colors.black.withOpacity(0.7),
          overlayOpacity: 0.7,
          targetBorderRadius: BorderRadius.circular(16),
          child: FloatingActionButton(
            heroTag: 'main_medication_fab',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<MedicationCubit>(),
                    child: const AddMedicationScreen(),
                  ),
                ),
              );
            },
            tooltip: l10n.addNewMedication,
            child: const Icon(Icons.add),
          ),
        );

      case 1: // صفحة المواعيد
        return Showcase(
          key: _addScheduleFabKey,
          title: l10n.showcaseAddScheduleTitle, // مترجم
          description: l10n.showcaseAddScheduleDesc, // مترجم
          overlayColor: Colors.black.withOpacity(0.7),
          overlayOpacity: 0.7,
          targetBorderRadius: BorderRadius.circular(16),
          child: FloatingActionButton(
            heroTag: 'main_schedule_fab',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<ScheduleCubit>(),
                    child: const AddScheduleGroupScreen(),
                  ),
                ),
              );
            },
            tooltip: l10n.addNewSchedule,
            child: const Icon(Icons.add_alarm),
          ),
        );

      case 2: // صفحة الصحة
        return FloatingActionButton(
          heroTag: 'main_health_fab',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<HealthLogCubit>(),
                  child: const AddHealthReadingScreen(),
                ),
              ),
            );
          },
          tooltip: l10n.addNewReading,
          child: const Icon(Icons.add_chart),
        );

      default:
        return const SizedBox();
    }
  }

  Widget _buildNotificationBell(BuildContext context) {
    return BlocBuilder<MedicationCubit, MedicationState>(
      builder: (context, state) {
        int count = 0;
        if (state is MedicationLoaded) {
          count = state.lowStockCount;
        }

        return Padding(
          padding: const EdgeInsetsDirectional.only(end: 16.0),
          child: IconButton(
            icon: Badge(
              isLabelVisible: count > 0,
              label: Text('$count'),
              backgroundColor: Colors.redAccent,
              child: Icon(
                count > 0
                    ? Icons.notifications_active_rounded
                    : Icons.notifications_none_rounded,
                color: count > 0
                    ? Colors.redAccent
                    : Theme.of(context).iconTheme.color,
                size: 28,
              ),
            ),
            tooltip: 'الإشعارات',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<MedicationCubit>(),
                    child: const NotificationsScreen(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
