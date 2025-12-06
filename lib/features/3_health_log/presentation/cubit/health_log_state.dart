// (1) ده هيعمل ايرور مؤقتاً كالعادة
part of 'health_log_cubit.dart';

// (2) بنستورد الـ Entity بتاعنا

// (3) "الأب" المجرد لكل الحالات
abstract class HealthLogState extends Equatable {
  const HealthLogState();

  @override
  List<Object> get props => [];
}

// (4) الحالات الفعلية:

// --- الحالة 1: الابتدائية ---
class HealthLogInitial extends HealthLogState {}

// --- الحالة 2: جاري تحميل القراءات ---
class HealthLogLoading extends HealthLogState {}

// --- الحالة 3: تم تحميل القراءات بنجاح ---
class HealthLogLoaded extends HealthLogState {
  // (5) الحالة دي شايلة "قايمة كل القراءات" (ضغط وسكر)
  final List<HealthReading> readings;

  const HealthLogLoaded(this.readings);

  @override
  List<Object> get props => [readings];
}

// --- الحالة 4: حدث خطأ ---
class HealthLogError extends HealthLogState {
  final String message;

  const HealthLogError(this.message);

  @override
  List<Object> get props => [message];
}
