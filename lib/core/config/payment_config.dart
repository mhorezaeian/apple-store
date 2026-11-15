/// تنظیمات درگاه پرداخت در یک کلاس.
///
/// چرا جدا؟ (اصل Single Responsibility + Dependency Injection)
///  - Merchant ID و حالت Sandbox داخل UI یا UseCase هاردکد نمی‌شوند.
///  - رفتن از Sandbox به درگاه واقعی فقط با پارامتر build انجام می‌شود، بدون تغییر کد.
class PaymentConfig {
  final String merchantId;
  final bool isSandbox;
  final String callbackUrl;

  const PaymentConfig({
    required this.merchantId,
    required this.isSandbox,
    required this.callbackUrl,
  });

  /// Merchant ID تستی (فقط برای Sandbox)
  static const String _sandboxMerchantId =
      '2159c865-8818-4c25-bf74-69cc49c6280c';

  /// مقدارها را از --dart-define می‌خواند.
  /// پیش‌فرض Sandbox است (fail-safe): اگر کسی فراموش کند، پول واقعی جابه‌جا نمی‌شود.
  ///
  /// نسخه نهایی:
  /// flutter build apk --dart-define=ZARINPAL_SANDBOX=false \
  ///   --dart-define=ZARINPAL_MERCHANT_ID=<id-واقعی>
  factory PaymentConfig.fromEnvironment() {
    const isSandbox = bool.fromEnvironment(
      'ZARINPAL_SANDBOX',
      defaultValue: true,
    );
    const merchantId = String.fromEnvironment(
      'ZARINPAL_MERCHANT_ID',
      defaultValue: _sandboxMerchantId,
    );
    const callbackUrl = String.fromEnvironment(
      'PAYMENT_CALLBACK',
      defaultValue: 'bamamad://appleshop', // باید با intent-filter یکی باشد
    );

    // محافظ: درگاه واقعی با Merchant ID تستی یعنی فراموش کردن پیکربندی
    if (!isSandbox && merchantId == _sandboxMerchantId) {
      throw StateError(
        'برای درگاه واقعی باید ZARINPAL_MERCHANT_ID واقعی داده شود.',
      );
    }

    return const PaymentConfig(
      merchantId: merchantId,
      isSandbox: isSandbox,
      callbackUrl: callbackUrl,
    );
  }
}
