import 'package:equatable/equatable.dart';

// (1) ده الـ Entity النضيف اللي بيمثل "مجموعة مواعيد"
// زي "جرعة الصباح"، الساعة 8:00، أيام (السبت، الأحد، الثلاثاء)
class ScheduleGroup extends Equatable {
  // (2) الـ ID (nullable عشان المجموعة الجديدة)
  final int? id;

  // (3) اسم المجموعة (جرعة الصباح)
  final String name;

  // (4) التوقيت
  final int hour; // (0-23)
  final int minute; // (0-59)

  // (5) أيام الأسبوع (النقطة الأهم)
  // ده "Set" (مجموعة) من الأرقام بتمثل الأيام
  // مثلاً {1, 2, 3} = (الاثنين، الثلاثاء، الأربعاء)
  // (1 = الاثنين، 7 = الأحد)
  final Set<int> daysOfWeek;

  // (6) هل المنبه ده شغال ولا المستخدم موقفه؟
  final bool isActive;

  const ScheduleGroup({
    this.id,
    required this.name,
    required this.hour,
    required this.minute,
    required this.daysOfWeek,
    required this.isActive,
  });

  // (7) الـ props عشان الـ Equatable
  @override
  List<Object?> get props => [id, name, hour, minute, daysOfWeek, isActive];
}
