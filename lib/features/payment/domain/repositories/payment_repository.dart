import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/basket/domain/entities/basket_item.dart';
import 'package:apple_store/features/payment/domain/entities/payment_result.dart';
import 'package:apple_store/features/payment/domain/entities/payment_session.dart';
import 'package:apple_store/features/payment/domain/entities/pending_payment.dart';
import 'package:dartz/dartz.dart';

/// قرارداد پرداخت. UseCaseها فقط این interface را می‌شناسند؛
/// نه زرین‌پال را و نه Hive را (Dependency Inversion).
abstract class PaymentRepository {
  /// درخواست به درگاه + ذخیره snapshot (authority، مبلغ، آیتم‌ها)
  Future<Either<Failure, PaymentSession>> startPayment({
    required int amount,
    required String description,
    required List<BasketItem> items,
  });

  /// خواندن snapshot. اگر authority ناشناخته باشد (لینک جعلی یا قدیمی) Failure می‌دهد.
  Future<Either<Failure, PendingPayment>> getPending(String authority);

  /// تأیید پرداخت نزد درگاه با همان مبلغ درخواست اولیه
  Future<Either<Failure, PaymentResult>> verifyPayment({
    required String authority,
    required String status,
    required int amount,
  });

  /// فقط pending همین تراکنش پاک می‌شود، نه همه
  Future<void> clearPending(String authority);
}
