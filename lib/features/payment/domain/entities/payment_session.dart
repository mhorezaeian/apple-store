/// نتیجه «شروع پرداخت». مستقل از هر درگاه و هر پکیجی.
class PaymentSession {
  /// شناسه یکتای تراکنش در درگاه (Authority)
  final String authority;

  /// آدرسی که باید در مرورگر باز شود
  final String gatewayUrl;

  const PaymentSession({required this.authority, required this.gatewayUrl});
}
