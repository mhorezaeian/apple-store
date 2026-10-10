import 'package:apple_store/features/basket/domain/entities/basket_item.dart';
import 'package:apple_store/features/product/domain/entities/variant.dart';

final class PriceFormatter {
  const PriceFormatter._();

  static String format(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)},',
    );
  }

  static String discountPercent(int price, int discountPrice) {
    if (price <= 0 || discountPrice <= 0) {
      return '0';
    }

    return ((discountPrice / price) * 100).round().toString();
  }

  static int finalPrice(int price, int discountPrice) {
    return price - discountPrice;
  }

  /// Payable unit price: `(base price - discount amount) + variant surcharges`.
  static int unitPayablePrice({
    required int? basePrice,
    required int? discountAmount,
    List<Variant>? variants,
  }) {
    final base = basePrice ?? 0;
    final discount = discountAmount ?? 0;
    final variantSum = (variants ?? []).fold<int>(
      0,
      (sum, variant) => sum + (variant.priceChange ?? 0),
    );
    return (base - discount) + variantSum;
  }

  static int unitListPrice({required int? basePrice, List<Variant>? variants}) {
    final base = basePrice ?? 0;
    final variantSum = (variants ?? []).fold<int>(
      0,
      (sum, variant) => sum + (variant.priceChange ?? 0),
    );
    return base + variantSum;
  }

  static int lineTotal(BasketItem item) {
    return unitPayablePrice(
          basePrice: item.price,
          discountAmount: item.discountPrice,
          variants: item.variants,
        ) *
        (item.quantity ?? 1);
  }

  static int basketTotal(Iterable<BasketItem> items) {
    return items.fold<int>(0, (sum, item) => sum + lineTotal(item));
  }
}
