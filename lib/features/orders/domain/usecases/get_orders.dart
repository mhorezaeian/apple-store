import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/orders/domain/entities/order.dart';
import 'package:apple_store/features/orders/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart' hide Order;

/// UseCase: خواندن سابقه خرید (جدیدترین اول).
class GetOrders {
  final OrderRepository _repository;
  GetOrders(this._repository);

  Future<Either<Failure, List<Order>>> call() => _repository.getOrders();
}
