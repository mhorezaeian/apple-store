// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  String? id;
  String? name;
  String? description;
  int? price;
  int? discount_price;
  int? real_price;
  String? popularity;
  int? quantity;
  String? imsgeUrl;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount_price,
    required this.popularity,
    required this.quantity,
    required this.imsgeUrl,
  }) : real_price = (price ?? 0) - (discount_price ?? 0);
}
