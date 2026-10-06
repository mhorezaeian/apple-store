import 'package:apple_store/features/product/domain/entities/variant.dart';

class BasketItem {
  final String? id;
  final String? productId;
  final String? name;
  final int? price;
  final int? discountPrice;
  final String? thumbnail;
  final int? quantity;
  final List<Variant>? variants;

  const BasketItem({
    this.id,
    this.productId,
    this.name,
    this.price,
    this.discountPrice,
    this.thumbnail,
    this.quantity,
    this.variants,
  });
}
