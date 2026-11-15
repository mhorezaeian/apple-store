import 'package:apple_store/features/payment/domain/usecases/start_payment.dart';
import 'package:apple_store/features/payment/domain/usecases/verify_payment.dart';
import 'package:bloc/bloc.dart';

part 'payment_event.dart';
part 'payment_state.dart';

/// Bloc فقط «مدیریت وضعیت» را انجام می‌دهد.
/// هیچ قانون کسب‌وکاری اینجا نیست؛ آن‌ها در UseCaseها هستند.
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final StartPayment _startPayment;
  final VerifyPayment _verifyPayment;

  /// authorityهایی که پردازششان تمام شده (موفق یا لغو).
  /// اگر deep link تکراری برسد (مثلاً بعد از موفقیت)، دوباره verify نمی‌شود
  /// و پیام خطای گمراه‌کننده نشان داده نمی‌شود.
  final Set<String> _processedAuthorities = {};

  PaymentBloc(this._startPayment, this._verifyPayment)
    : super(const PaymentInitial()) {
    on<PaymentStarted>(_onStarted);
    on<PaymentCallbackReceived>(_onCallback);
  }

  /// آیا همین الان یک درخواست در جریان است؟
  bool get _isBusy => state is PaymentLoading || state is PaymentVerifying;

  Future<void> _onStarted(
    PaymentStarted event,
    Emitter<PaymentState> emit,
  ) async {
    // دفاع دوم در برابر کلیک تکراری (UI تنها محافظ قابل اعتماد نیست)
    if (_isBusy) return;

    emit(const PaymentLoading());

    final result = await _startPayment();
    result.fold(
      (failure) => emit(PaymentFailed(failure.message)),
      (session) => emit(PaymentRedirect(session.gatewayUrl)),
    );
  }

  Future<void> _onCallback(
    PaymentCallbackReceived event,
    Emitter<PaymentState> emit,
  ) async {
    // دفاع سوم: deep link تکراری هنگام verify یا بعد از پردازش نادیده گرفته می‌شود
    if (state is PaymentVerifying) return;
    if (_processedAuthorities.contains(event.authority)) return;

    emit(const PaymentVerifying());

    final result = await _verifyPayment(
      authority: event.authority,
      status: event.status,
    );

    result.fold(
      // خطا (مثلاً timeout): authority را «پردازش‌شده» حساب نمی‌کنیم تا امکان تلاش مجدد باشد
      (failure) => emit(PaymentFailed(failure.message)),
      (payment) {
        _processedAuthorities.add(event.authority);
        emit(
          payment.isSuccess
              ? PaymentSuccess(payment.refId!)
              : const PaymentFailed('پرداخت ناموفق بود یا لغو شد.'),
        );
      },
    );
  }
}
