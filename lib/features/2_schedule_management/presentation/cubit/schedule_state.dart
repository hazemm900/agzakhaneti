// (1) ده هيعمل ايرور مؤقتاً كالعادة
part of 'schedule_cubit.dart';

// (2) "الأب" المجرد لكل الحالات
abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

// (3) الحالات الفعلية:

// --- الحالة 1: الابتدائية ---
class ScheduleInitial extends ScheduleState {}

// --- الحالة 2: جاري تحميل المواعيد ---
class ScheduleLoading extends ScheduleState {}

// --- الحالة 3: تم تحميل المواعيد بنجاح ---
class ScheduleLoaded extends ScheduleState {
  // الحالة دي شايلة قايمة "مجموعات المواعيد" (زي جرعة الصباح، جرعة المساء)
  final List<ScheduleGroup> scheduleGroups;

  const ScheduleLoaded(this.scheduleGroups);

  @override
  List<Object> get props => [scheduleGroups];
}

// --- الحالة 4: حدث خطأ ---
class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError(this.message);

  @override
  List<Object> get props => [message];
}

// (ملحوظة: دي الحالات الأساسية. ممكن نحتاج نضيف حالات تانية بعدين
// زي "جاري إضافة دواء للمجموعة" أو "تم عرض تفاصيل المجموعة"
// بس خلينا نبدأ بسيطين)
