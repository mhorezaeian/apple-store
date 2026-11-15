import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/core/utils/price_formatter.dart';
import 'package:apple_store/features/basket/domain/repositories/basket_repository.dart';
import 'package:apple_store/features/payment/domain/entities/payment_session.dart';
import 'package:apple_store/features/payment/domain/repositories/payment_repository.dart';
import 'package:dartz/dartz.dart';

/// UseCase: شروع پرداخت.
/// قانون کسب‌وکار: مبلغ از آیتم‌های سبد (منبع معتبر) حساب می‌شود، نه از UI.
class StartPayment {
  final BasketRepository _basketRepository;
  final PaymentRepository _paymentRepository;

  StartPayment(this._basketRepository, this._paymentRepository);

  Future<Either<Failure, PaymentSession>> call() async {
    final basketResult = await _basketRepository.getBasket();

    return basketResult.fold<Future<Either<Failure, PaymentSession>>>(
      // خواندن سبد شکست خورد: همان Failure را برگردان
      (failure) async => left(failure),
      (items) async {
        // سبد خالی نباید به درگاه برود
        if (items.isEmpty) {
          return left(const PaymentFailure(message: 'سبد خرید خالی است.'));
        }

        final total = PriceFormatter.basketTotal(items);
        if (total <= 0) {
          return left(const PaymentFailure(message: 'مبلغ سفارش نامعتبر است.'));
        }

        return _paymentRepository.startPayment(
          amount: total,
          description: 'خرید از فروشگاه اپل',
          items: items, // snapshot آیتم‌ها کنار مبلغ ذخیره می‌شود
        );
      },
    );
  }
}
