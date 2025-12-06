import 'package:agzakhaneti/app/services/notification_service.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/add_schedule_group.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/delete_schedule_group.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/get_all_schedule_groups.dart';
import 'package:agzakhaneti/features/2_schedule_management/domain/usescases/update_schedule_group.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/schedule_group.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final NotificationService notificationService;
  final GetAllScheduleGroups getAllScheduleGroups;
  final AddScheduleGroup addScheduleGroup;
  final UpdateScheduleGroup updateScheduleGroup;
  final DeleteScheduleGroup deleteScheduleGroup;

  ScheduleCubit({
    required this.notificationService,
    required this.getAllScheduleGroups,
    required this.addScheduleGroup,
    required this.updateScheduleGroup,
    required this.deleteScheduleGroup,
  }) : super(ScheduleInitial());

  /// دالة لجلب كل مجموعات المواعيد
  Future<void> loadScheduleGroups() async {
    try {
      emit(ScheduleLoading());
      final groups = await getAllScheduleGroups();
      emit(ScheduleLoaded(groups));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  /// دالة لإضافة مجموعة مواعيد جديدة
  Future<void> addNewScheduleGroup(ScheduleGroup group) async {
    try {
      await addScheduleGroup(group);

      final allGroups = await getAllScheduleGroups();
      final addedGroup = allGroups.firstWhere(
        (g) =>
            g.name == group.name &&
            g.hour == group.hour &&
            g.minute == group.minute,
        orElse: () => allGroups.last,
      );

      await _scheduleGroupNotifications(addedGroup);
      emit(ScheduleLoaded(allGroups));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  /// دالة لتعديل مجموعة
  Future<void> updateExistingScheduleGroup(ScheduleGroup group) async {
    try {
      // (1) (مهم) محتاجين بيانات المجموعة "قبل" التعديل عشان نلغي المنبه القديم
      // (دي نقطة مهمة إحنا نسيناها المرة اللي فاتت)
      final allGroups = await getAllScheduleGroups();
      final oldGroup = allGroups.firstWhere((g) => g.id == group.id);

      // (2) بنلغي المنبهات القديمة (ببيانات الـ oldGroup)
      await _cancelGroupNotifications(oldGroup);

      // (3) بنحدث في الداتابيز
      await updateScheduleGroup(group);

      // (4) لو المجموعة "متفعلة"، بنعمل منبهات جديدة (ببيانات الـ group الجديدة)
      if (group.isActive) {
        await _scheduleGroupNotifications(group);
      }

      // (5) بنحدث القايمة
      await loadScheduleGroups();
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  /// دالة لحذف مجموعة
  Future<void> deleteExistingScheduleGroup(int groupId) async {
    try {
      final allGroups = await getAllScheduleGroups();
      final groupToDelete = allGroups.firstWhere((g) => g.id == groupId);

      await _cancelGroupNotifications(groupToDelete);
      await deleteScheduleGroup(groupId);

      allGroups.remove(groupToDelete);
      emit(ScheduleLoaded(allGroups));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  // --- (هنا الدالة مرة واحدة بس) ---
  /// دالة لجدولة المنبهات لمجموعة واحدة
  Future<void> _scheduleGroupNotifications(ScheduleGroup group) async {
    if (group.id == null) return;

    print('CUBIT: 🔁 بجدول المنبهات لمجموعة: ${group.name} (ID: ${group.id})');

    for (int dayOfWeek in group.daysOfWeek) {
      final notificationId = (group.id! * 100) + dayOfWeek;

      await notificationService.scheduleWeeklyNotification(
        id: notificationId,
        title: group.name,
        body: 'حان الآن ميعاد ${group.name}. اضغط لأخذ الجرعة.',
        dayOfWeek: dayOfWeek,
        time: TimeOfDay(hour: group.hour, minute: group.minute),

        // (مهم جداً) بنبعت الـ ID
        groupId: group.id!,
      );
    }
  }

  // --- (وهنا الدالة مرة واحدة بس) ---
  /// دالة لإلغاء المنبهات لمجموعة واحدة
  Future<void> _cancelGroupNotifications(ScheduleGroup group) async {
    if (group.id == null) return;

    print('CUBIT: 🚫 بلغي المنبهات لمجموعة: ${group.name}');
    // final bool isAndroid = Platform.isAndroid;

    for (int dayOfWeek in group.daysOfWeek) {
      final notificationId = (group.id! * 100) + dayOfWeek;
      await notificationService.cancelNotification(
        notificationId,
        // isAndroid: isAndroid,
      );
    }
  }
}
