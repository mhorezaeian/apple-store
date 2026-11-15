import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/orders/data/datasources/order_datasource.dart';
import 'package:apple_store/features/orders/data/models/order_model.dart';
import 'package:apple_store/features/orders/domain/entities/order.dart';
import 'package:apple_store/features/orders/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart' hide Order;

/// Exception فنی را به Failure قابل نمایش تبدیل می‌کند (مثل BasketRepositoryImpl).
class OrderRepositoryImpl implements OrderRepository {
  final OrderDatasource _datasource;

  OrderRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, void>> saveOrder(Order order) async {
    try {
      await _datasource.saveOrder(OrderModel.fromEntity(order));
      return right(null);
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.message));
    } catch (_) {
      return left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<Order>>> getOrders() async {
    try {
      final models = await _datasource.getOrders();
      return right(models.map((model) => model.toEntity()).toList());
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.message));
    } catch (_) {
      return left(const UnknownFailure());
    }
  }
}
