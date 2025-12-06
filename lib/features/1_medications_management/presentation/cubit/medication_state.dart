part of 'medication_cubit.dart'; // (1) ده هيعمل ايرور مؤقتاً

// (2) بنعمل "عقد" أو "Interface" لكل الحالات
// وبنخليه يورث من Equatable عشان الـ BlocBuilder يعرف إمتى يبني الشاشة
abstract class MedicationState extends Equatable {
  const MedicationState();

  @override
  List<Object> get props => [];
}

// (3) دي الحالات الفعلية اللي الـ Cubit هيبعتها:

// --- الحالة 1: الابتدائية (أول ما الشاشة تفتح) ---
class MedicationInitial extends MedicationState {}

// --- الحالة 2: جاري التحميل (لما نكون بنجيب الداتا من الداتابيز) ---
class MedicationLoading extends MedicationState {}

// --- الحالة 3: تم التحميل (نجحنا وجبنا الداتا) ---
class MedicationLoaded extends MedicationState {
  final List<Medication> medications;
  // (جديد) (1) ضيفنا العدد هنا
  final int lowStockCount;

  const MedicationLoaded(
    this.medications,
    this.lowStockCount, // (جديد) (2) ضيفناه في الكونستركتور
  );

  @override
  // (جديد) (3) ضيفناه للـ props
  List<Object> get props => [medications, lowStockCount];
}

// --- الحالة 4: حدث خطأ (الداتابيز ضربت مثلاً) ---
class MedicationError extends MedicationState {
  // الحالة دي لازم تشيل "رسالة الخطأ" عشان نعرضها
  final String message;

  const MedicationError(this.message);

  @override
  List<Object> get props => [message];
}
