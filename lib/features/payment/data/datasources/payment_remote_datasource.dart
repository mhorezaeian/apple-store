import 'package:apple_store/features/payment/data/models/payment_result_model.dart';
import 'package:apple_store/features/payment/data/models/payment_session_model.dart';

/// قرارداد ارتباط با درگاه.
/// برای درگاه دیگر (Zibal، IDPay، ...) فقط همین را پیاده‌سازی می‌کنی
/// و یک خط در DI عوض می‌شود (Open/Closed).
///
/// [amount] همیشه «تومان» است؛ تبدیل به واحد درگاه وظیفه‌ی پیاده‌سازی است.
abstract class PaymentRemoteDatasource {
  Future<PaymentSessionModel> request(int amount, String description);

  Future<PaymentResultModel> verify({
    required String authority,
    required String status,
    required int amount,
  });
}
