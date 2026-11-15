/// نتیجه «تأیید پرداخت» (Verify).
class PaymentResult {
  /// آیا درگاه پرداخت را تأیید کرد؟
  final bool isSuccess;

  /// کد پیگیری؛ فقط در پرداخت موفق مقدار دارد
  final String? refId;

  const PaymentResult({required this.isSuccess, this.refId});
}
