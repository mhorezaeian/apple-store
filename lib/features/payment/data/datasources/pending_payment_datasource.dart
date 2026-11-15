import 'package:apple_store/features/payment/data/models/pending_payment_model.dart';

/// قرارداد ذخیره‌ی تراکنش‌های در انتظار.
abstract class PendingPaymentDatasource {
  Future<void> save(PendingPaymentModel pending);

  /// اگر authority ناشناخته باشد null برمی‌گرداند
  PendingPaymentModel? get(String authority);

  Future<void> delete(String authority);
}
