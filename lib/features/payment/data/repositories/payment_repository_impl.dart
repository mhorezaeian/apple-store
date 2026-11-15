import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/basket/domain/entities/basket_item.dart';
import 'package:apple_store/features/payment/data/datasources/payment_remote_datasource.dart';
import 'package:apple_store/features/payment/data/datasources/pending_payment_datasource.dart';
import 'package:apple_store/features/payment/data/models/pending_payment_model.dart';
import 'package:apple_store/features/payment/domain/entities/payment_result.dart';
import 'package:apple_store/features/payment/domain/entities/payment_session.dart';
import 'package:apple_store/features/payment/domain/entities/pending_payment.dart';
import 'package:apple_store/features/payment/domain/repositories/payment_repository.dart';
import 'package:dartz/dartz.dart';

/// هماهنگ‌کننده‌ی DataSourceها و مترجم Exception (فنی) به Failure (قابل نمایش).
class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDatasource _remote;
  final PendingPaymentDatasource _local;

  PaymentRepositoryImpl({
    required PaymentRemoteDatasource remote,
    required PendingPaymentDatasource local,
  }) : _remote = remote,
       _local = local;

  @override
  Future<Either<Failure, PaymentSession>> startPayment({
    required int amount,
    required String description,
    required List<BasketItem> items,
  }) async {
    try {
      final session = await _remote.request(amount, description);

      // snapshot را قبل از رفتن کاربر به مرورگر ذخیره می‌کنیم
      await _local.save(
        PendingPaymentModel.fromEntity(
          PendingPayment(
            authority: session.authority,
            amount: amount,
            items: items,
          ),
        ),
      );

      return right(
        PaymentSession(
          authority: session.authority,
          gatewayUrl: session.gatewayUrl,
        ),
      );
    } on PaymentException catch (e) {
      return left(PaymentFailure(message: e.message));
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.message));
    } catch (_) {
      return left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, PendingPayment>> getPending(String authority) async {
    try {
      final model = _local.get(authority);
      if (model == null) {
        // لینک جعلی، قدیمی یا قبلاً پردازش‌شده
        return left(const PaymentFailure(message: 'تراکنش معتبر نیست.'));
      }
      return right(model.toEntity());
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.message));
    } catch (_) {
      return left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, PaymentResult>> verifyPayment({
    required String authority,
    required String status,
    required int amount,
  }) async {
    // کاربر در درگاه لغو کرده (Status=NOK): نیازی به تماس با سرور نیست
    if (status.toUpperCase() != 'OK') {
      return right(const PaymentResult(isSuccess: false));
    }

    try {
      final result = await _remote.verify(
        authority: authority,
        status: status,
        amount: amount,
      );
      return right(
        PaymentResult(isSuccess: result.isSuccess, refId: result.refId),
      );
    } on PaymentException catch (e) {
      return left(PaymentFailure(message: e.message));
    } catch (_) {
      return left(const UnknownFailure());
    }
  }

  @override
  Future<void> clearPending(String authority) async {
    try {
      await _local.delete(authority);
    } catch (_) {
      // پاک نشدن pending نباید جریان پرداخت را خراب کند
    }
  }
}
