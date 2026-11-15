/// Model لایه Data برای نتیجه‌ی شروع پرداخت (خروجی DataSource).
class PaymentSessionModel {
  final String authority;
  final String gatewayUrl;

  const PaymentSessionModel({
    required this.authority,
    required this.gatewayUrl,
  });
}
