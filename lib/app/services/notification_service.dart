import 'dart:math';
import 'package:agzakhaneti/app/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:agzakhaneti/features/1_medications_management/domain/repositories/medication_repository.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/repositories/schedule_repository.dart';
import 'package:get_it/get_it.dart';

@pragma('vm:entry-point')
class NotificationService {
  // طلب الصلاحيات
  Future<void> requestPermissions() async {
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  // تهيئة الخدمة والقنوات
  Future<void> initListeners() async {
    await AwesomeNotifications().initialize(
      null,
      [
        // قناة المنبه (صوت عالي)
        NotificationChannel(
          channelGroupKey: 'medication_channel_group',
          channelKey: 'medication_alarm_channel',
          channelName: 'Medication Alarms',
          channelDescription: 'High priority alarms for medication',
          defaultColor: const Color(0xFF3B82F6),
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          criticalAlerts: true,
          playSound: true,
          soundSource: 'resource://raw/alarm_sound',
          // (1) تصليح: شيلنا wakeUpScreen و fullScreenIntent من هنا (مكانهم غلط)
        ),

        // قناة التنبيهات العادية (نقص المخزون)
        NotificationChannel(
          channelGroupKey: 'medication_channel_group',
          channelKey: 'medication_stock_channel',
          channelName: 'Low Stock Alerts',
          channelDescription: 'Notifications for low medication stock',
          defaultColor: Colors.red,
          importance: NotificationImportance.High,
          playSound: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'medication_channel_group',
          channelGroupName: 'Medication Group',
        ),
      ],
      debug: true,
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
  }

  // --- الدالة السحرية للزراير ---
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // "إنعاش" التطبيق في الخلفية
    try {
      if (!GetIt.I.isRegistered<ScheduleRepository>()) {
        await setupServiceLocator();
      }
    } catch (e) {
      await setupServiceLocator();
    }

    print('🔔 Action Received: ${receivedAction.buttonKeyPressed}');
    print('📦 Payload: ${receivedAction.payload}'); // (ضيف السطر ده)

    // --- سيناريو 1: أخذ الجرعة ---
    if (receivedAction.buttonKeyPressed == 'TAKE') {
      try {
        final payload = receivedAction.payload;
        if (payload != null && payload.containsKey('groupId')) {
          final int groupId = int.parse(payload['groupId']!);

          final scheduleRepo = sl<ScheduleRepository>();
          final medicationRepo = sl<MedicationRepository>();

          final meds = await scheduleRepo.getMedicationsForGroup(groupId);

          for (final med in meds) {
            final newStock = med.currentStock - med.doseValue;
            final updatedMed = med.copyWith(currentStock: newStock);
            await medicationRepo.updateMedication(updatedMed);

            print('✅ Deducted ${med.name}. New Stock: $newStock');

            if (newStock <= med.refillReminderStock) {
              await _showLowStockNotification(med.name, newStock);
            }
          }

          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: Random().nextInt(100000),
              channelKey: 'medication_stock_channel',
              title: 'تم أخذ الجرعة ✅',
              body: 'تم خصم الجرعات من المخزون بنجاح.',
              notificationLayout: NotificationLayout.Default,
              autoDismissible: true,
            ),
          );

          if (receivedAction.id != null) {
            await AwesomeNotifications().cancel(receivedAction.id!);
          }
        }
      } catch (e) {
        print('❌ Error taking dose: $e');
      }
    }
    // --- سيناريو 2: الغفوة ---
    else if (receivedAction.buttonKeyPressed == 'SNOOZE') {
      print('💤 Snooze Clicked!');

      if (receivedAction.id != null) {
        await AwesomeNotifications().cancel(receivedAction.id!);
      }

      // (2) تصليح: جدولة الغفوة باستخدام NotificationCalendar.fromDate
      // دي أسهل وأضمن من Interval عشان نتجنب مشاكل الـ Duration
      final snoozedTime = DateTime.now().add(const Duration(minutes: 10));

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: receivedAction.id! + 999,
          channelKey: 'medication_alarm_channel',
          title: 'غفوة: ${receivedAction.title}',
          body: 'حان موعد الدواء (بعد الغفوة).',
          notificationLayout: NotificationLayout.Default,

          // (تعديل 1) غيرنا الفئة لـ Reminder
          category: NotificationCategory.Reminder,

          // (تعديل 2) خلينا الشاشة تنور بس متفتحش التطبيق
          wakeUpScreen: true,
          fullScreenIntent: false,

          autoDismissible: false,
          payload: receivedAction.payload,
          customSound: 'resource://raw/alarm_sound',
        ),

        // (4) تصليح: استخدام fromDate للجدولة الدقيقة
        schedule: NotificationCalendar.fromDate(
          date: snoozedTime,
          allowWhileIdle: true,
          preciseAlarm: true,
        ),
        actionButtons: _getButtons(),
      );
    }
    // --- سيناريو 3: الإلغاء ---
    else if (receivedAction.buttonKeyPressed == 'CANCEL') {
      if (receivedAction.id != null) {
        await AwesomeNotifications().cancel(receivedAction.id!);
      }
    }
  }

  static Future<void> _showLowStockNotification(
    String medName,
    double currentStock,
  ) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(100000),
        channelKey: 'medication_stock_channel',
        title: 'تنبيه نقص المخزون ⚠️',
        body: 'الدواء "$medName" قرب يخلص! المتبقي: $currentStock',
        notificationLayout: NotificationLayout.Default,
        color: Colors.red,
      ),
    );
  }

  static List<NotificationActionButton> _getButtons() {
    return [
      NotificationActionButton(
        key: 'TAKE',
        label: 'أخذ الجرعة',
        color: Colors.green,
        autoDismissible: true,
        actionType: ActionType.SilentAction,
      ),
      NotificationActionButton(
        key: 'SNOOZE',
        label: 'غفوة (10 دق)',
        autoDismissible: true,
        actionType: ActionType.SilentAction,
      ),
      NotificationActionButton(
        key: 'CANCEL',
        label: 'إلغاء',
        actionType: ActionType.DismissAction,
        isDangerousOption: true,
      ),
    ];
  }

  Future<void> scheduleWeeklyNotification({
    required int id,
    required String title,
    required String body,
    required int dayOfWeek,
    required TimeOfDay time,
    required int groupId,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'medication_alarm_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,

        // (تعديل 1) غيرناها لـ Reminder بدل Alarm
        // ده هيخلي الصوت يشتغل بس التطبيق ميفطش في وشك
        category: NotificationCategory.Reminder,

        // (تعديل 2) ينور الشاشة بس
        wakeUpScreen: true,
        fullScreenIntent: false,

        autoDismissible: false,
        payload: {'groupId': groupId.toString()},
        customSound: 'resource://raw/alarm_sound',
      ),
      // ... باقي الكود زي ما هو
      schedule: NotificationCalendar(
        weekday: dayOfWeek,
        hour: time.hour,
        minute: time.minute,
        second: 0,
        millisecond: 0,
        repeats: true,
        allowWhileIdle: true,
        preciseAlarm: true,
      ),
      actionButtons: _getButtons(),
    );
    print('🔔 Scheduled: ID $id at Day $dayOfWeek ${time.hour}:${time.minute}');
  }

  Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }
}
