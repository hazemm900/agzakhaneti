// (1) ده هيعمل ايرور مؤقتاً كالعادة
part of 'schedule_detail_cubit.dart';

// (2) بنستورد الـ Entity بتاع الدواء (لأننا هنعرض قايمة أدوية)

// (3) "الأب" المجرد لكل الحالات
abstract class ScheduleDetailState extends Equatable {
  const ScheduleDetailState();

  @override
  List<Object> get props => [];
}

// (4) الحالات الفعلية:

// --- الحالة 1: الابتدائية ---
class ScheduleDetailInitial extends ScheduleDetailState {}

// --- الحالة 2: جاري تحميل الأدوية المرتبطة بالمجموعة ---
class ScheduleDetailLoading extends ScheduleDetailState {}

// --- الحالة 3: تم تحميل الأدوية بنجاح ---
class ScheduleDetailLoaded extends ScheduleDetailState {
  // (5) أهم حاجة: الحالة دي شايلة قايمة "الأدوية المرتبطة" بالجرعة دي
  final List<Medication> linkedMedications;

  const ScheduleDetailLoaded(this.linkedMedications);

  @override
  List<Object> get props => [linkedMedications];
}

// --- الحالة 4: حدث خطأ ---
class ScheduleDetailError extends ScheduleDetailState {
  final String message;

  const ScheduleDetailError(this.message);

  @override
  List<Object> get props => [message];
}
