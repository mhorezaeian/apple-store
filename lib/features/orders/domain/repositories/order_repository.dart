import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/orders/domain/entities/order.dart';
import 'package:dartz/dartz.dart' hide Order;

/// قرارداد سفارش‌ها. لایه‌های بالاتر فقط این interface را می‌شناسند، نه Hive را.
abstract class OrderRepository {
  Future<Either<Failure, void>> saveOrder(Order order);
  Future<Either<Failure, List<Order>>> getOrders();
}
