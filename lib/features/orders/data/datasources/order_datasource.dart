import 'package:apple_store/features/orders/data/models/order_model.dart';

/// قرارداد منبع داده‌ی سفارش‌ها (مثل BasketDatasource).
/// اگر روزی به API وصل شویم، فقط یک پیاده‌سازی دیگر می‌نویسیم.
abstract class OrderDatasource {
  Future<void> saveOrder(OrderModel order);
  Future<List<OrderModel>> getOrders();
}
