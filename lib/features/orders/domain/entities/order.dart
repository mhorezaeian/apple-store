import 'package:apple_store/features/basket/domain/entities/basket_item.dart';
import 'package:equatable/equatable.dart';

/// وضعیت سفارش. فعلاً فقط سفارش موفق ذخیره می‌شود؛
/// بعداً می‌شود pending/refunded اضافه کرد.
enum OrderStatus { success }

/// Entity سفارش: کلاس خالص Dart، بدون وابستگی به Hive یا Flutter.
class Order extends Equatable {
  /// شناسه سفارش = کد پیگیری درگاه (refId). یکتا است.
  final String id;

  /// آیتم‌هایی که واقعاً پولشان پرداخت شده (snapshot زمان شروع پرداخت)
  final List<BasketItem> items;

  /// مبلغ پرداخت‌شده (تومان)
  final int total;

  final DateTime date;
  final OrderStatus status;

  const Order({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
    required this.status,
  });

  @override
  List<Object?> get props => [id, items, total, date, status];
}
