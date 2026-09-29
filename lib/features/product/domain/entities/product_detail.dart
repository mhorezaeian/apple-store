class ProductDetail {
  String? id;
  String? name;
  String? description;
  int? price;
  int? discount_price;
  int? real_price;
  String? popularity;
  int? quantity;
  String? imsgeUrl;
  String? category;

  ProductDetail({
    this.id,
    this.name,
    this.description,
    this.price,
    this.discount_price,
    this.popularity,
    this.quantity,
    this.imsgeUrl,
    this.category,
  }) : real_price = (price ?? 0) - (discount_price ?? 0);
}
