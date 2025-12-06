import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:agzakhaneti/app/di/service_locator.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/get_medications_for_group.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/link_medication_to_group.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/unlink_medication_from_group.dart';

import '../../domain/entities/schedule_group.dart';
import '../cubit/schedule_detail_cubit.dart';

import '../widgets/medication_selection_dialog.dart';
import '../widgets/linked_medication_card.dart';
import '../widgets/linked_medication_empty_state.dart';

// 1. الغلاف (Wrapper)
class ScheduleDetailScreen extends StatelessWidget {
  final ScheduleGroup scheduleGroup;

  const ScheduleDetailScreen({super.key, required this.scheduleGroup});

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: (context) {
        return _ScheduleDetailContent(scheduleGroup: scheduleGroup);
      },
    );
  }
}

// 2. المحتوى الحقيقي
class _ScheduleDetailContent extends StatefulWidget {
  final ScheduleGroup scheduleGroup;
  const _ScheduleDetailContent({required this.scheduleGroup});

  @override
  State<_ScheduleDetailContent> createState() => _ScheduleDetailContentState();
}

class _ScheduleDetailContentState extends State<_ScheduleDetailContent> {
  final GlobalKey _linkFabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowLinkShowcase();
    });
  }

  Future<void> _checkAndShowLinkShowcase() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenLinkTutorial =
        prefs.getBool('seen_link_tutorial') ?? false;

    if (!hasSeenLinkTutorial) {
      if (mounted) {
        ShowCaseWidget.of(context).startShowCase([_linkFabKey]);
        await prefs.setBool('seen_link_tutorial', true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (context) => ScheduleDetailCubit(
        getMedicationsForGroup: sl<GetMedicationsForGroup>(),
        linkMedicationToGroup: sl<LinkMedicationToGroup>(),
        unlinkMedicationFromGroup: sl<UnlinkMedicationFromGroup>(),
        scheduleGroup: widget.scheduleGroup,
      )..loadLinkedMedications(),
      child: Builder(
        builder: (innerContext) {
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              title: Column(
                children: [
                  Text(
                    widget.scheduleGroup.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.scheduleGroup.hour.toString().padLeft(2, '0')}:${widget.scheduleGroup.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onBackground.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: BlocBuilder<ScheduleDetailCubit, ScheduleDetailState>(
              builder: (context, state) {
                if (state is ScheduleDetailLoading ||
                    state is ScheduleDetailInitial) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.primary,
                    ),
                  );
                }
                if (state is ScheduleDetailLoaded) {
                  if (state.linkedMedications.isEmpty) {
                    return const LinkedMedicationEmptyState();
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.linkedMedications.length,
                    separatorBuilder: (ctx, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final medication = state.linkedMedications[index];
                      return LinkedMedicationCard(
                        medication: medication,
                        onUnlink: () {
                          context.read<ScheduleDetailCubit>().unlinkMedication(
                            medication.id!,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Unlinked ${medication.name}"),
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return Center(child: Text(tr.unknownState));
              },
            ),
            floatingActionButton: Showcase(
              key: _linkFabKey,
              title: tr.showcaseLinkMedTitle, // مترجم: ربط الدواء
              description: tr.showcaseLinkMedDesc, // مترجم: الشرح
              targetBorderRadius: BorderRadius.circular(16),
              overlayOpacity: 0.7,
              child: FloatingActionButton.extended(
                heroTag: 'schedule_link_fab',
                onPressed: () {
                  final cubit = innerContext.read<ScheduleDetailCubit>();
                  final currentState = cubit.state;
                  if (currentState is ScheduleDetailLoaded) {
                    showDialog(
                      context: innerContext,
                      builder: (dialogContext) => BlocProvider.value(
                        value: cubit,
                        child: MedicationSelectionDialog(
                          alreadyLinkedMedications:
                              currentState.linkedMedications,
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.link_rounded),
                label: Text(tr.linkMedicationTooltip),
                backgroundColor: colorScheme.primary,
                foregroundColor: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
