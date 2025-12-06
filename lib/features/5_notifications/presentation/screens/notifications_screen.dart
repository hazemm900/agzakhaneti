import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import '../../../1_medications_management/presentation/cubit/medication_cubit.dart';
import '../../../1_medications_management/domain/entities/medication.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_empty_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(l10n.notificationsLowStockTitle),
        centerTitle: true,
      ),
      body: BlocBuilder<MedicationCubit, MedicationState>(
        builder: (context, state) {
          if (state is MedicationLoading || state is MedicationInitial) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          }

          if (state is MedicationError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    color: colorScheme.error,
                    size: 50,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${l10n.errorOccurred}: ${state.message}',
                    style: TextStyle(color: colorScheme.error),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is MedicationLoaded) {
            final List<Medication> lowStockMeds = state.medications
                .where((med) => med.currentStock <= med.refillReminderStock)
                .toList();

            if (lowStockMeds.isEmpty) {
              return const NotificationEmptyState(); // 👇 Clean Usage
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: lowStockMeds.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return NotificationCard(
                  medication: lowStockMeds[index],
                ); // 👇 Clean Usage
              },
            );
          }

          return Center(child: Text(l10n.notificationsNoData));
        },
      ),
    );
  }
}
