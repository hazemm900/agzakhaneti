import 'package:agzakhaneti/app/services/database_service.dart';

import '../../domain/entities/schedule_group.dart'; // (2) بنورث من الـ Entity

// (3) الـ Model بيورث من الـ Entity
class ScheduleGroupModel extends ScheduleGroup {
  const ScheduleGroupModel({
    super.id,
    required super.name,
    required super.hour,
    required super.minute,
    required super.daysOfWeek,
    required super.isActive,
  });

  // --- (4) الدالة الأهم: التحويل من Map (الداتابيز) إلى Object ---
  factory ScheduleGroupModel.fromMap(Map<String, dynamic> map) {
    // (5) دي "الترجمة" من "1,2,3" إلى {1, 2, 3}
    final daysString = map[colGroupDaysOfWeek] as String;
    final Set<int> daysSet = daysString
        .split(',') // هيحول "1,2,3" إلى ["1", "2", "3"]
        .where((s) => s.isNotEmpty) // (احتياطي) عشان يتجاهل لو في فواصل زيادة
        .map((s) => int.parse(s)) // هيحول كل String لـ int
        .toSet(); // هيحول القايمة لـ Set

    return ScheduleGroupModel(
      id: map[colGroupId] as int?,
      name: map[colGroupName] as String,
      hour: map[colGroupHour] as int,
      minute: map[colGroupMinute] as int,
      daysOfWeek: daysSet, // (6) بنستخدم الـ Set اللي ترجمناه
      // بنشيك على 1 أو 0 في الداتابيز
      isActive: (map[colGroupIsActive] as int) == 1,
    );
  }

  // --- (7) الدالة التانية: التحويل من Object إلى Map (للداتابيز) ---
  Map<String, dynamic> toMap() {
    // (8) دي "الترجمة" من {1, 2, 3} إلى "1,2,3"
    final String daysString = daysOfWeek
        .map((day) => day.toString()) // هيحول {1, 2, 3} إلى ("1", "2", "3")
        .join(','); // هيلمهم في نص واحد بـ "فاصلة"

    return {
      if (id != null) colGroupId: id,
      colGroupName: name,
      colGroupHour: hour,
      colGroupMinute: minute,
      colGroupDaysOfWeek: daysString, // (9) بنخزن النص المترجم
      // بنخزن true كـ 1 و false كـ 0
      colGroupIsActive: isActive ? 1 : 0,
    };
  }
}
