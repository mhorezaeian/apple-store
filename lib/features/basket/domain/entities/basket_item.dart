import 'package:equatable/equatable.dart';
import 'package:apple_store/features/product/domain/entities/variant.dart';

class BasketItem extends Equatable {
  final String? id;
  final String? productId;
  final String? name;
  final int? price;
  final int? discountPrice;
  final String? thumbnail;
  final int quantity;
  final List<Variant> variants;

  const BasketItem({
    this.id,
    this.productId,
    this.name,
    this.price,
    this.discountPrice,
    this.thumbnail,
    this.quantity = 1,
    this.variants = const [],
  });

  Set<String> get variantIds =>
      variants.map((v) => v.id).whereType<String>().toSet();

  /// مقایسه بدون توجه به ترتیب واریانت‌ها
  bool hasSameConfiguration(String productId, Iterable<String?> ids) {
    final other = ids.whereType<String>().toSet();
    return this.productId == productId &&
        variantIds.length == other.length &&
        variantIds.containsAll(other);
  }

  BasketItem copyWith({int? quantity}) => BasketItem(
    id: id,
    productId: productId,
    name: name,
    price: price,
    discountPrice: discountPrice,
    thumbnail: thumbnail,
    quantity: quantity ?? this.quantity,
    variants: variants,
  );

  @override
  List<Object?> get props => [
    id,
    productId,
    name,
    price,
    discountPrice,
    thumbnail,
    quantity,
    variants,
  ];
}
