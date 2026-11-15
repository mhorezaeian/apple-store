/// Model لایه Data برای نتیجه‌ی verify (خروجی DataSource).
class PaymentResultModel {
  final bool isSuccess;
  final String? refId;

  const PaymentResultModel({required this.isSuccess, this.refId});
}
