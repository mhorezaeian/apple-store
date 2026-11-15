import 'package:apple_store/features/basket/data/models/basket_item_model.dart';
import 'package:apple_store/features/orders/domain/entities/order.dart';
import 'package:hive/hive.dart';

// فایل order_model.g.dart را build_runner می‌سازد
part 'order_model.g.dart';

/// Model سفارش برای Hive (لایه Data).
/// typeId باید در کل پروژه یکتا باشد (۰ و ۱ برای سبد و واریانت استفاده شده‌اند).
@HiveType(typeId: 10)
class OrderModel {
  @HiveField(0)
  final String id;

  /// از BasketItemModel استفاده می‌کنیم که adapter آن از قبل ثبت شده است.
  @HiveField(1)
  final List<BasketItemModel> items;

  @HiveField(2)
  final int total;

  /// تاریخ به‌صورت میلی‌ثانیه ذخیره می‌شود (ساده و بدون adapter اضافه)
  @HiveField(3)
  final int dateMillis;

  /// وضعیت به‌صورت رشته ذخیره می‌شود تا با اضافه شدن وضعیت جدید، داده قدیمی خراب نشود.
  @HiveField(4)
  final String status;

  OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.dateMillis,
    required this.status,
  });

  /// Entity ← Model (برای ذخیره)
  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      items: order.items.map(BasketItemModel.fromEntity).toList(),
      total: order.total,
      dateMillis: order.date.millisecondsSinceEpoch,
      status: order.status.name,
    );
  }

  /// Model → Entity (برای نمایش)
  Order toEntity() {
    return Order(
      id: id,
      items: items.map((item) => item.toEntity()).toList(),
      total: total,
      date: DateTime.fromMillisecondsSinceEpoch(dateMillis),
      status: OrderStatus.values.firstWhere(
        (s) => s.name == status,
        orElse: () => OrderStatus.success,
      ),
    );
  }
}
