// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  String? id;
  String? name;
  int? price;
  int? discount_price;
  int? real_price;
  String? popularity;
  String? imsgeUrl;
  String? category;
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.discount_price,
    required this.popularity,
    required this.imsgeUrl,
    required this.category,
  }) : real_price = (price ?? 0) - (discount_price ?? 0);
}
