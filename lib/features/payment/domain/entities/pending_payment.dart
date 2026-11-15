import 'package:apple_store/features/basket/domain/entities/basket_item.dart';

/// تراکنشی که شروع شده ولی هنوز verify نشده (همان snapshot).
///
/// چرا ذخیره می‌شود؟
///  1) کاربر برای پرداخت از اپ خارج می‌شود و سیستم‌عامل ممکن است اپ را kill کند.
///  2) کاربر ممکن است وسط پرداخت سبد را تغییر دهد؛ سفارش باید دقیقاً مطابق
///     چیزی باشد که پولش پرداخت شده، و verify باید با همان مبلغ انجام شود.
class PendingPayment {
  final String authority;

  /// مبلغ به تومان (تبدیل به ریال فقط در DataSource زرین‌پال انجام می‌شود)
  final int amount;
  final List<BasketItem> items;

  const PendingPayment({
    required this.authority,
    required this.amount,
    required this.items,
  });
}
