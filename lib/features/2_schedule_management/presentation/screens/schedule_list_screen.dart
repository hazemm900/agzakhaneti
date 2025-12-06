import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/schedule_cubit.dart';
import 'add_schedule_group_screen.dart';
import 'schedule_detail_screen.dart';
import '../widgets/schedule_card.dart';
import '../widgets/schedule_empty_state.dart';

class ScheduleListScreen extends StatelessWidget {
  const ScheduleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder<ScheduleCubit, ScheduleState>(
        builder: (context, state) {
          // 1. Loading State
          if (state is ScheduleLoading || state is ScheduleInitial) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.primary,
              ),
            );
          }

          // 2. Data State
          if (state is ScheduleLoaded) {
            if (state.scheduleGroups.isEmpty) {
              return const ScheduleEmptyState(); // 👇 استخدام الودجت
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: state.scheduleGroups.length,
              itemBuilder: (context, index) {
                final group = state.scheduleGroups[index];

                return ScheduleCard(
                  scheduleGroup: group,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<ScheduleCubit>(context),
                          child: AddScheduleGroupScreen(
                            scheduleGroupToEdit: group,
                          ),
                        ),
                      ),
                    );
                  },
                  onDelete: () {
                    context.read<ScheduleCubit>().deleteExistingScheduleGroup(
                      group.id!,
                    );
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ScheduleDetailScreen(scheduleGroup: group),
                      ),
                    );
                  },
                );
              },
            );
          }

          // 3. Error State
          if (state is ScheduleError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: colorScheme.error),
                  const SizedBox(height: 16),
                  Text(
                    '${tr.errorOccurred}: ${state.message}',
                    style: TextStyle(color: colorScheme.onBackground),
                  ),
                ],
              ),
            );
          }

          return Center(child: Text(tr.unknownState));
        },
      ),
    );
  }
}
