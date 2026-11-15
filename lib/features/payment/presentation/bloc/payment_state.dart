part of 'payment_bloc.dart';

/// وضعیت‌ها (خروجی Bloc): «الان در چه حالتی هستیم؟»
///
/// عمداً Equatable نیست: اگر دو بار پشت سر هم PaymentFailed با یک پیام بیاید،
/// باید هر دو بار SnackBar نشان داده شود، ولی با Equatable حالت دوم «تکراری» حساب
/// و emit نمی‌شد.
sealed class PaymentState {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

/// در حال ساخت درخواست پرداخت
class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

/// آماده‌ی باز کردن درگاه؛ UI مرورگر را باز می‌کند
class PaymentRedirect extends PaymentState {
  final String url;
  const PaymentRedirect(this.url);
}

/// در حال تأیید پرداخت نزد درگاه
class PaymentVerifying extends PaymentState {
  const PaymentVerifying();
}

class PaymentSuccess extends PaymentState {
  final String refId;
  const PaymentSuccess(this.refId);
}

class PaymentFailed extends PaymentState {
  final String message;
  const PaymentFailed(this.message);
}
