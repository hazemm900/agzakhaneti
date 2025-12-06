import 'package:agzakhaneti/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../widgets/health_log_chart_tab.dart';
import '../widgets/health_log_list_tab.dart';

class HealthLogScreen extends StatefulWidget {
  const HealthLogScreen({super.key});

  @override
  State<HealthLogScreen> createState() => _HealthLogScreenState();
}

class _HealthLogScreenState extends State<HealthLogScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            height: 50,
            decoration: BoxDecoration(
              color: colorScheme.surface, // لون الكارت (أبيض/غامق)
              borderRadius: BorderRadius.circular(25.0), // حواف دائرية بالكامل
              boxShadow: [
                BoxShadow(
                  color: theme.brightness == Brightness.dark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              // (3) المؤشر: عبارة عن كبسولة ملونة بتتحرك
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: colorScheme.primary, // اللون الأساسي (أزرق)
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              // (4) ألوان النصوص
              labelColor:
                  Colors.white, // النص المختار دايماً أبيض عشان الخلفية زرقاء
              unselectedLabelColor: colorScheme.onSurface.withOpacity(
                0.6,
              ), // النص الغير مختار رمادي
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              indicatorSize:
                  TabBarIndicatorSize.tab, // المؤشر يملأ المساحة كلها
              dividerColor: Colors.transparent, // إخفاء الخط الفاصل التقليدي
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.format_list_bulleted_rounded, size: 20),
                      const SizedBox(width: 8),
                      Text(l10n.healthLogTabList),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.pie_chart_rounded, size: 20),
                      const SizedBox(width: 8),
                      Text(l10n.healthLogTabReports),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // (5) المحتوى
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                HealthLogListTab(), // هنعدلها حالاً
                HealthLogChartTab(), // دي بقى "التقيل" كله
              ],
            ),
          ),
        ],
      ),
    );
  }
}
