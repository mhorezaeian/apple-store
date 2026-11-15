import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/orders/domain/usecases/place_order.dart';
import 'package:apple_store/features/payment/domain/entities/payment_result.dart';
import 'package:apple_store/features/payment/domain/entities/pending_payment.dart';
import 'package:apple_store/features/payment/domain/repositories/payment_repository.dart';
import 'package:dartz/dartz.dart';

/// UseCase: تأیید پرداخت. ترتیب کار:
///   snapshot را بخوان ← verify نزد درگاه ← ثبت سفارش (PlaceOrder) ← پاک کردن pending
///
/// ثبت سفارش و خالی کردن سبد در PlaceOrder است تا این کلاس فقط «هماهنگ‌کننده‌ی پرداخت» بماند.
class VerifyPayment {
  final PaymentRepository _paymentRepository;
  final PlaceOrder _placeOrder;

  VerifyPayment(this._paymentRepository, this._placeOrder);

  Future<Either<Failure, PaymentResult>> call({
    required String authority,
    required String status,
  }) async {
    // 1) authority ناشناخته = لینک جعلی یا قدیمی ← همین‌جا متوقف می‌شویم
    final pendingResult = await _paymentRepository.getPending(authority);

    return pendingResult.fold<Future<Either<Failure, PaymentResult>>>(
      (failure) async => left(failure),
      (pending) => _verifyAndPlaceOrder(pending, status),
    );
  }

  Future<Either<Failure, PaymentResult>> _verifyAndPlaceOrder(
    PendingPayment pending,
    String status,
  ) async {
    // 2) تنها منبع معتبر نتیجه، پاسخ verify درگاه است؛ نه Status داخل URL (قابل جعل است)
    final verifyResult = await _paymentRepository.verifyPayment(
      authority: pending.authority,
      status: status,
      amount: pending.amount, // دقیقاً همان مبلغ درخواست اولیه
    );

    return verifyResult.fold<Future<Either<Failure, PaymentResult>>>(
      // خطای شبکه/timeout: pending را نگه می‌داریم تا بشود دوباره تلاش کرد
      (failure) async => left(failure),
      (payment) async {
        // پرداخت لغو یا ناموفق: سفارشی ساخته نمی‌شود و pending لازم نیست
        if (!payment.isSuccess) {
          await _paymentRepository.clearPending(pending.authority);
          return right(payment);
        }

        final refId = payment.refId;
        if (refId == null) {
          return left(const PaymentFailure(message: 'کد پیگیری دریافت نشد.'));
        }

        // 3) ثبت سفارش از snapshot و خالی کردن سبد
        final orderResult = await _placeOrder(orderId: refId, pending: pending);

        return orderResult.fold<Future<Either<Failure, PaymentResult>>>(
          // پول پرداخت شده ولی ثبت سفارش شکست خورده:
          // pending را پاک نمی‌کنیم و کد پیگیری را به کاربر نشان می‌دهیم.
          (failure) async => left(
            PaymentFailure(
              message:
                  'پرداخت تأیید شد اما ثبت سفارش ناموفق بود. '
                  'کد پیگیری: $refId',
            ),
          ),
          (_) async {
            await _paymentRepository.clearPending(pending.authority);
            return right(payment);
          },
        );
      },
    );
  }
}
