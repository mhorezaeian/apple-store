import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/features/orders/data/datasources/order_datasource.dart';
import 'package:apple_store/features/orders/data/models/order_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// تنها کلاسی که Box سفارش‌ها را می‌شناسد.
class OrderLocalDataSource implements OrderDatasource {
  final Box<OrderModel> orderBox;

  OrderLocalDataSource({required this.orderBox});

  /// کلید = شناسه سفارش (refId).
  /// اگر verify دوباره اجرا شود روی همان رکورد می‌نشیند و سفارش تکراری ساخته نمی‌شود.
  @override
  Future<void> saveOrder(OrderModel order) async {
    try {
      await orderBox.put(order.id, order);
    } catch (e) {
      throw LocalStorageException(
        message: 'Failed to save order to local storage.',
        error: e,
      );
    }
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      // جدیدترین سفارش اول
      return orderBox.values.toList()
        ..sort((a, b) => b.dateMillis.compareTo(a.dateMillis));
    } catch (e) {
      throw LocalStorageException(
        message: 'Failed to get orders from local storage.',
        error: e,
      );
    }
  }
}
