part of 'payment_bloc.dart';

/// رویدادها (ورودی Bloc): «چه اتفاقی افتاد؟»
sealed class PaymentEvent {
  const PaymentEvent();
}

/// کاربر دکمه‌ی «ادامه فرآیند خرید» را زد
class PaymentStarted extends PaymentEvent {
  const PaymentStarted();
}

/// کاربر از درگاه برگشت (deep link رسید)
class PaymentCallbackReceived extends PaymentEvent {
  final String authority;
  final String status;

  const PaymentCallbackReceived({
    required this.authority,
    required this.status,
  });
}
