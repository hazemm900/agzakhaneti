import 'package:agzakhaneti/app/utils/enums.dart';
import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/health_reading.dart';
import '../cubit/health_log_cubit.dart';

class HealthLogChartTab extends StatelessWidget {
  const HealthLogChartTab({super.key});

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
            child: Text(
              l10n.healthLogErrorOccurred(state.message),
              style: TextStyle(color: colorScheme.error),
            ),
          );
        }
        if (state is HealthLogLoaded) {
          if (state.readings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bar_chart_rounded,
                    size: 80,
                    color: colorScheme.onSurface.withOpacity(0.2),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.healthLogNoData,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            );
          }

          // ترتيب البيانات من القديم للحديث عشان الرسم البياني يمشي صح (من الشمال لليمين)
          final allReadings = List<HealthReading>.from(state.readings);
          allReadings.sort((a, b) => a.timestamp.compareTo(b.timestamp));

          final pressureReadings = allReadings
              .where((r) => r.type == HealthReadingType.bloodPressure)
              .toList();
          final sugarReadings = allReadings
              .where((r) => r.type == HealthReadingType.bloodSugar)
              .toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- كارت تقرير الضغط ---
                _ChartCard(
                  title: l10n.healthLogBloodPressureReport,
                  icon: Icons.favorite_rounded,
                  iconColor: Colors.pinkAccent,
                  isEmpty: pressureReadings.length < 2,
                  emptyMessage: l10n.healthLogBloodPressureNeedTwo,
                  child: _buildBloodPressureChart(context, pressureReadings),
                ),

                const SizedBox(height: 24),

                // --- كارت تقرير السكر ---
                _ChartCard(
                  title: l10n.healthLogBloodSugarReport,
                  icon: Icons.water_drop_rounded,
                  iconColor: Colors.cyan,
                  isEmpty: sugarReadings.length < 2,
                  emptyMessage: l10n.healthLogBloodSugarNeedTwo,
                  child: _buildBloodSugarChart(context, sugarReadings),
                ),

                const SizedBox(height: 50), // مساحة إضافية تحت
              ],
            ),
          );
        }

        return Center(child: Text(l10n.healthLogUnknownState));
      },
    );
  }

  // --- 1. Blood Pressure Chart Builder ---
  Widget _buildBloodPressureChart(
    BuildContext context,
    List<HealthReading> readings,
  ) {
    final theme = Theme.of(context);

    // تحويل القراءات لنقاط (Spots)
    final systolicSpots = readings
        .map(
          (r) => FlSpot(
            r.timestamp.millisecondsSinceEpoch.toDouble(),
            r.systolic!.toDouble(),
          ),
        )
        .toList();
    final diastolicSpots = readings
        .map(
          (r) => FlSpot(
            r.timestamp.millisecondsSinceEpoch.toDouble(),
            r.diastolic!.toDouble(),
          ),
        )
        .toList();

    return LineChart(
      LineChartData(
        // إعدادات التفاعل (Tooltip)
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            // لون خلفية التول تيب (متوافق مع الدارك مود)
            tooltipBgColor: theme.cardColor,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                // تنسيق النص جوه البالونة
                return LineTooltipItem(
                  '${spot.y.toInt()}',
                  TextStyle(color: spot.bar.color, fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false, // نخفي الخطوط الطولية عشان الزحمة
          horizontalInterval: 20, // خط عرضي كل 20 درجة
          getDrawingHorizontalLine: (value) => FlLine(
            color: theme.dividerColor.withOpacity(0.2),
            strokeWidth: 1,
            dashArray: [5, 5], // خط منقط
          ),
        ),
        titlesData: _buildTitlesData(context), // العناوين الجانبية والسفلية
        borderData: FlBorderData(show: false), // إخفاء البرواز الخارجي
        // --- خطوط الرسم ---
        lineBarsData: [
          // خط الانقباضي (Systolic) - أحمر/وردي
          LineChartBarData(
            isCurved: true,
            color: Colors.pinkAccent,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: false,
            ), // إخفاء النقاط العادية (تظهر عند اللمس بس)
            belowBarData: BarAreaData(
              show: true,
              color: Colors.pinkAccent.withOpacity(0.1), // ظل خفيف تحت الخط
            ),
            spots: systolicSpots,
          ),
          // خط الانبساطي (Diastolic) - أزرق
          LineChartBarData(
            isCurved: true,
            color: Colors.blueAccent,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blueAccent.withOpacity(0.1),
            ),
            spots: diastolicSpots,
          ),
        ],
        // تظبيط حدود الرسم (Min/Max) عشان الرسمة تكون متوسطنة
        minY: 40,
        maxY: 200,
      ),
    );
  }

  // --- 2. Blood Sugar Chart Builder ---
  Widget _buildBloodSugarChart(
    BuildContext context,
    List<HealthReading> readings,
  ) {
    final theme = Theme.of(context);
    final sugarSpots = readings
        .map(
          (r) => FlSpot(
            r.timestamp.millisecondsSinceEpoch.toDouble(),
            r.sugarLevel!.toDouble(),
          ),
        )
        .toList();

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: theme.cardColor,
            getTooltipItems: (touchedSpots) {
              return touchedSpots
                  .map(
                    (spot) => LineTooltipItem(
                      '${spot.y.toInt()} mg/dL',
                      const TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  .toList();
            },
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 50,
          getDrawingHorizontalLine: (value) => FlLine(
            color: theme.dividerColor.withOpacity(0.2),
            strokeWidth: 1,
            dashArray: [5, 5],
          ),
        ),
        titlesData: _buildTitlesData(context),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: Colors.cyan,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true), // إظهار النقاط في السكر
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                // تدرج لوني تحت الخط
                colors: [
                  Colors.cyan.withOpacity(0.3),
                  Colors.cyan.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            spots: sugarSpots,
          ),
        ],
        minY: 50,
        maxY: 400,
      ),
    );
  }

  // --- Helper: Axis Titles Config ---
  FlTitlesData _buildTitlesData(BuildContext context) {
    final theme = Theme.of(context);
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 32,
          interval: 86400000 * 2, // عرض تاريخ كل يومين تقريباً (عشان الزحمة)
          getTitlesWidget: (value, meta) {
            final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
            // تنسيق التاريخ (مثال: 3 Oct)
            final text = DateFormat('d MMM', 'en').format(date);
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                text,
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          getTitlesWidget: (value, meta) {
            return Text(
              value.toInt().toString(),
              style: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
                fontSize: 10,
              ),
            );
          },
        ),
      ),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}

// --- 3. Custom Chart Card Widget (Design Wrapper) ---
class _ChartCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;
  final bool isEmpty;
  final String emptyMessage;

  const _ChartCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.child,
    required this.isEmpty,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Chart Body
          AspectRatio(
            aspectRatio: 1.5, // نسبة العرض للطول (عشان الرسمة تبقى متناسقة)
            child: isEmpty
                ? Center(
                    child: Text(
                      emptyMessage,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface.withOpacity(0.4),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : child,
          ),
        ],
      ),
    );
  }
}
