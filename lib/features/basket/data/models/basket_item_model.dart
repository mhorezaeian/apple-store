import 'package:hive/hive.dart';
import 'package:apple_store/features/basket/domain/entities/basket_item.dart';
import 'package:apple_store/features/product/data/models/variant_model.dart';

part 'basket_item_model.g.dart';

@HiveType(typeId: 0)
class BasketItemModel extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? productId;

  @HiveField(2)
  final String? name;

  @HiveField(3)
  final int? price;

  @HiveField(4)
  final int? discountPrice;

  @HiveField(5)
  final String? thumbnail;

  @HiveField(6)
  final int? quantity;

  @HiveField(7)
  final List<VariantModel>? variants;

  BasketItemModel({
    this.id,
    this.productId,
    this.name,
    this.price,
    this.discountPrice,
    this.thumbnail,
    this.quantity,
    this.variants,
  });

  BasketItem toEntity() {
    return BasketItem(
      id: id,
      productId: productId,
      name: name,
      price: price,
      discountPrice: discountPrice,
      thumbnail: thumbnail,
      quantity: quantity,
      variants: variants?.map((variant) => variant.toEntity()).toList(),
    );
  }

  factory BasketItemModel.fromEntity(BasketItem entity) {
    return BasketItemModel(
      id: entity.id,
      productId: entity.productId,
      name: entity.name,
      price: entity.price,
      discountPrice: entity.discountPrice,
      thumbnail: entity.thumbnail,
      quantity: entity.quantity,
      variants: entity.variants
          ?.map((variant) => VariantModel.fromEntity(variant))
          .toList(),
    );
  }
}
