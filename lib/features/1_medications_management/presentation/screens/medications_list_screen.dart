import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/medication_cubit.dart';
import 'add_medication_screen.dart';

// استدعاء الودجتس المنفصلة
import '../widgets/medication_card.dart';
import '../widgets/medication_empty_state.dart';
import '../widgets/dose_confirm_dialog.dart';

class MedicationsListScreen extends StatelessWidget {
  const MedicationsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder<MedicationCubit, MedicationState>(
        builder: (context, state) {
          // 1. حالة التحميل
          if (state is MedicationLoading || state is MedicationInitial) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.primary,
              ),
            );
          }

          // 2. حالة الخطأ
          if (state is MedicationError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: colorScheme.error),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: TextStyle(
                      color: colorScheme.onBackground.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            );
          }

          // 3. حالة النجاح وعرض البيانات
          if (state is MedicationLoaded) {
            if (state.medications.isEmpty) {
              return const MedicationEmptyState();
            }

            return ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 80),
              itemCount: state.medications.length,
              itemBuilder: (context, index) {
                final medication = state.medications[index];

                return MedicationCard(
                  medication: medication,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<MedicationCubit>(),
                          child: AddMedicationScreen(
                            medicationToEdit: medication,
                          ),
                        ),
                      ),
                    );
                  },
                  onDelete: () {
                    context.read<MedicationCubit>().deleteExistingMedication(
                      medication.id!,
                    );
                  },
                  onTakeDose: () {
                    // 👇 فتح الديالوج المنفصل
                    showDialog(
                      context: context,
                      builder: (_) => DoseConfirmDialog(medication: medication),
                    );
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
