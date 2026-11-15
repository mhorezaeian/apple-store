import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/basket/domain/repositories/basket_repository.dart';
import 'package:apple_store/features/orders/domain/entities/order.dart';
import 'package:apple_store/features/orders/domain/repositories/order_repository.dart';
import 'package:apple_store/features/payment/domain/entities/pending_payment.dart';
import 'package:dartz/dartz.dart' hide Order;

/// UseCase: ثبت سفارش بعد از پرداخت موفق.
///
/// قانون کسب‌وکار:
///  1) سفارش از snapshot ساخته می‌شود (نه سبد فعلی)، چون ممکن است کاربر
///     وسط پرداخت سبد را تغییر داده باشد.
///  2) ترتیب مهم است: اول سفارش ذخیره می‌شود، بعد سبد خالی می‌شود.
///     در بدترین حالت سبد پر می‌ماند، نه اینکه هم سفارش و هم سبد از دست بروند.
class PlaceOrder {
  final OrderRepository _orderRepository;
  final BasketRepository _basketRepository;

  PlaceOrder(this._orderRepository, this._basketRepository);

  Future<Either<Failure, Order>> call({
    required String orderId, // کد پیگیری درگاه
    required PendingPayment pending,
  }) async {
    final order = Order(
      id: orderId,
      items: pending.items,
      total: pending.amount, // همان عددی که واقعاً به درگاه رفت
      date: DateTime.now(),
      status: OrderStatus.success,
    );

    final saved = await _orderRepository.saveOrder(order);

    return saved.fold<Future<Either<Failure, Order>>>(
      (failure) async => left(failure),
      (_) async {
        // خالی نشدن سبد، پرداخت را ناموفق نمی‌کند؛ نتیجه‌اش را نادیده می‌گیریم.
        await _basketRepository.clearBasket();
        return right(order);
      },
    );
  }
}
