import 'package:agzakhaneti/app/di/service_locator.dart';
import 'package:agzakhaneti/app/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:awesome_notifications/awesome_notifications.dart'; // (1) البطل الجديد
import 'app/my_app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // (2) تهيئة Awesome Notifications
  // بنعرف القناة (Channel) هنا مرة واحدة
  await AwesomeNotifications().initialize(
    // 'resource://drawable/res_app_icon', // لو عاوزين نستخدم أيقونة التطبيق
    null, // (null بيستخدم الأيقونة الافتراضية)
    [
      NotificationChannel(
        channelGroupKey: 'medication_channel_group',
        channelKey: 'medication_channel',
        channelName: 'Medication Reminders',
        channelDescription: 'Notifications for medication schedules',
        defaultColor: const Color(0xFF3B82F6), // اللون الأزرق بتاعنا
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        criticalAlerts: true, // (مهم جداً عشان يرن ويفوق الموبايل)
        playSound: true,
      ),
    ],
    // (3) بنعرف مجموعات القنوات (اختياري للتنظيم)
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'medication_channel_group',
        channelGroupName: 'Medication Group',
      ),
    ],
    debug: true, // (عشان نشوف اللوجز في الـ Console)
  );

  await setupServiceLocator();

  // (4) بنهيأ الليسنرز (الزراير)
  await sl<NotificationService>().initListeners();

  runApp(const MyApp());

  await _initializeAppData();
  FlutterNativeSplash.remove();
}

Future<void> _initializeAppData() async {
  await Future.delayed(const Duration(seconds: 1));
}
