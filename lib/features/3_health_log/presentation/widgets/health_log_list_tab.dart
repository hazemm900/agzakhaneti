import 'package:agzakhaneti/features/3_health_log/presentation/screens/add_health_reading_screen.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/health_log_cubit.dart';
import 'health_reading_card.dart'; // استدعي الملف اللي عملناه فوق

class HealthLogListTab extends StatelessWidget {
  const HealthLogListTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<HealthLogCubit, HealthLogState>(
      builder: (context, state) {
        if (state is HealthLogLoading || state is HealthLogInitial) {
          return Center(
            child: CircularProgressIndicator(color: colorScheme.primary),
          );
        }

        if (state is HealthLogError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 50,
                  color: colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.healthLogErrorOccurred(state.message),
                  style: TextStyle(color: colorScheme.error),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        if (state is HealthLogLoaded) {
          if (state.readings.isEmpty) {
            return _buildEmptyState(context, l10n, colorScheme);
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80), // مساحة للـ FAB
            itemCount: state.readings.length,
            itemBuilder: (context, index) {
              final reading = state.readings[index];

              return HealthReadingCard(
                reading: reading,
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<HealthLogCubit>(context),
                        child: AddHealthReadingScreen(readingToEdit: reading),
                      ),
                    ),
                  );
                },
                onDelete: () {
                  // ممكن نضيف ديالوج تأكيد هنا
                  context.read<HealthLogCubit>().deleteExistingHealthReading(
                    reading.id!,
                  );
                },
              );
            },
          );
        }

        return Center(child: Text(l10n.healthLogUnknownReading));
      },
    );
  }

  // ودجت الحالة الفارغة (Medical Style)
  Widget _buildEmptyState(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.monitor_heart_outlined, // أيقونة طبية معبرة
              size: 80,
              color: Colors.blueAccent.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.healthLogNoReadings,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onBackground.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Start tracking your health now!", // نص تشجيعي
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onBackground.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
