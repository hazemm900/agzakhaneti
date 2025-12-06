import 'package:agzakhaneti/app/di/service_locator.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit for schedule detail
import '../cubit/schedule_detail_cubit.dart';

// Medication entity
import '../../../1_medications_management/domain/entities/medication.dart';

// UseCase: get all medications
import '../../../1_medications_management/domain/usecases/get_medications.dart';

class MedicationSelectionDialog extends StatefulWidget {
  final List<Medication> alreadyLinkedMedications;

  const MedicationSelectionDialog({
    super.key,
    required this.alreadyLinkedMedications,
  });

  @override
  State<MedicationSelectionDialog> createState() =>
      _MedicationSelectionDialogState();
}

class _MedicationSelectionDialogState extends State<MedicationSelectionDialog> {
  late final GetMedications _getMedicationsUseCase;

  bool _isLoading = true;
  String? _error;

  final List<Medication> _unlinkedMedications = [];

  @override
  void initState() {
    super.initState();
    _getMedicationsUseCase = sl<GetMedications>();
    _fetchUnlinkedMedications();
  }

  Future<void> _fetchUnlinkedMedications() async {
    setState(() => _isLoading = true);
    try {
      final allMedications = await _getMedicationsUseCase();

      final linkedIds = widget.alreadyLinkedMedications
          .map((med) => med.id)
          .toSet();

      final unlinked = allMedications
          .where((med) => !linkedIds.contains(med.id))
          .toList();

      setState(() {
        _unlinkedMedications
          ..clear()
          ..addAll(unlinked);
        _isLoading = false;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  void _linkMedication(Medication medicationToLink) {
    context.read<ScheduleDetailCubit>().linkMedication(medicationToLink.id!);

    // بنشيل الدواء من الليستة لحظياً عشان يديني إحساس بالاستجابة السريعة
    setState(() {
      _unlinkedMedications.remove(medicationToLink);
    });

    // feedback بسيط للمستخدم
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Linked ${medicationToLink.name} successfully"),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );

    // لو القائمة فضيت بعد الإضافة، ممكن نقفل الديالوج أوتوماتيك (اختياري)
    if (_unlinkedMedications.isEmpty) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // بنستخدم Dialog بدل AlertDialog عشان نتحكم في الـ Insets والـ Shape براحتنا
    return Dialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.all(20), // مسافة من حواف الشاشة
      child: Container(
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height *
              0.7, // اقصى ارتفاع 70% من الشاشة
          minHeight: 200,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // عشان الديالوج يصغر لو المحتوى قليل
          children: [
            // --- Header ---
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.link_rounded, color: colorScheme.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    loc.linkMedicationToSchedule,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close_rounded,
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: colorScheme.onSurface.withOpacity(0.1), height: 1),
            const SizedBox(height: 16),

            // --- Content List ---
            Flexible(child: _buildContent(loc, colorScheme)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(AppLocalizations loc, ColorScheme colorScheme) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(color: colorScheme.primary),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: colorScheme.error, size: 40),
            const SizedBox(height: 8),
            Text(
              '${loc.errorOccurred} $_error',
              textAlign: TextAlign.center,
              style: TextStyle(color: colorScheme.error),
            ),
          ],
        ),
      );
    }

    if (_unlinkedMedications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.green.withOpacity(0.5),
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              loc.allMedicationsLinked,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.6),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      itemCount: _unlinkedMedications.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final medication = _unlinkedMedications[index];
        final unitName = medication.doseUnit.toString().split('.').last;

        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border.all(color: colorScheme.onSurface.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            leading: Icon(
              Icons.medication_outlined,
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
            title: Text(
              medication.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              '${medication.doseValue} $unitName',
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
            trailing: ElevatedButton(
              onPressed: () => _linkMedication(medication),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    colorScheme.primary, // زرار مليان عشان يشد الانتباه
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                minimumSize: const Size(60, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text("Add"), // ممكن تستخدم loc.add أو أيقونة
            ),
          ),
        );
      },
    );
  }
}
