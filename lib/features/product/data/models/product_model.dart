// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:apple_store/features/product/domain/entities/product.dart';
import 'package:apple_store/features/product/domain/entities/product_detail.dart';

// {
//     "page": 1,
//     "perPage": 30,
//     "totalItems": 1,
//     "totalPages": 1,
//     "items": [
//         {
//             "category": "0fml1qqa0q17pk2",
//             "collectionId": "6s4mxhn1b9v0u2g",
//             "collectionName": "products",
//             "created": "2024-01-24 18:04:27.857Z",
//             "description": "ساعت‌های هوشمند اپل از سری لوازم جانبی جذاب و پرکاربردی هستند که همواره طرفداران اپل برای رونمایی از آن‌ در کنار سایر دستگاه‌های اپل انتظار می‌کشند. اپل سری 7 ساعت‌های هوشمند خود را در دو سایز 41 میلی‌متر و 45 میلی‌متر به بازار روانه می‌کند. این ساعت هوشمند نسبت به ساعت‌های هوشمند سری قبل اپل با صفحه‌نمایش خمیده ارائه شده‌است. همچنین حاشیه‌ها نسبت به سری قبل کمتر خواهد بود. اپل ساعت هوشمند سری 7 خود را در رنگ‌های سبز، آبی، قرمز، مشکی و استارلایت (starlight) ارائه کرده‌است. جنس بدنه کماکان آلومینیوم است. در این ساعت ویژگی‌های منحصربه‌فردی همچون سنسور اندازه‌گیری اکسیژن خون و برنامه سلامت ECG وجود دارد. اپل واج سری 7 صفحه نمایش لمسی خازنی دارد. صفحه نمایش این ساعت هوشمند OLED بوده و در برابر ترک خوردگی و گرد و غبار مقاوم است. عملکرد باتری این ساعت هوشمند 18 ساعت خواهد بود. این باتری نسبت به نسل قبل ساعت هوشمند در حدود 33 درصد بهبود پیدا کرده است و تنها 45 دقیقه تا شارژ 80 درصد ساعت هوشمندتان فاصله زمانی وجود دارد. نور صفحه نمایش در سری جدید اپل‌واچ در حدود 70 درصد بهبود پیدا کرده‌است.\r\n",
//             "discount_price": 1500000,
//             "id": "f3boue5hvtbv6ud",
//             "name": "اپل واچ سری ۷ ",
//             "popularity": "Best Seller",
//             "price": 11480000,
//             "quantity": 12,
//             "thumbnail": "apple_watch_se_gold_aluminum_case_with_sport_band_1_572x572_1_SqCu135sJC.png",
//             "updated": "2024-03-02 04:31:16.379Z"
//         }
//     ]
// }

class ProductModel {
  String? id;
  String? name;
  String? collectionId;
  String? description;
  int? price;
  int? discount_price;
  String? popularity;
  int? quantity;
  String? thumbnail;
  String? category;
  ProductModel({
    this.id,
    this.name,
    this.collectionId,
    this.description,
    this.price,
    this.discount_price,
    this.popularity,
    this.quantity,
    this.thumbnail,
    this.category,
  });

  Product toProductEntity() {
    return Product(
      id: id,
      name: name,
      price: price,
      discount_price: discount_price,
      popularity: popularity,
      imsgeUrl: thumbnail,
      category: category,
    );
  }

  ProductDetail toProductDetailEntity() {
    return ProductDetail(
      id: id,
      name: name,
      description: description,
      price: price,
      discount_price: discount_price,
      popularity: popularity,
      quantity: quantity,
      imsgeUrl: thumbnail,
      category: category,
    );
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? collectionId,
    String? description,
    int? price,
    int? discount_price,
    String? popularity,
    int? quantity,
    String? thumbnail,
    String? category,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      collectionId: collectionId ?? this.collectionId,
      description: description ?? this.description,
      price: price ?? this.price,
      discount_price: discount_price ?? this.discount_price,
      popularity: popularity ?? this.popularity,
      quantity: quantity ?? this.quantity,
      thumbnail: thumbnail ?? this.thumbnail,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'collectionId': collectionId,
      'description': description,
      'price': price,
      'discount_price': discount_price,
      'popularity': popularity,
      'quantity': quantity,
      'thumbnail': thumbnail,
      'category': category,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      collectionId: map['collectionId'] != null
          ? map['collectionId'] as String
          : null,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      price: map['price'] != null ? map['price'] as int : null,
      discount_price: map['discount_price'] != null
          ? map['discount_price'] as int
          : null,
      popularity: map['popularity'] != null
          ? map['popularity'] as String
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      thumbnail:
          'https://startflutter.ir/api/files/${map['collectionId'] as String}/${map['id'] as String}/${map['thumbnail'] as String}',
      category: map['category'] != null ? map['category'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, collectionId: $collectionId, description: $description, price: $price, discount_price: $discount_price, popularity: $popularity, quantity: $quantity, thumbnail: $thumbnail, category: $category)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.collectionId == collectionId &&
        other.description == description &&
        other.price == price &&
        other.discount_price == discount_price &&
        other.popularity == popularity &&
        other.quantity == quantity &&
        other.thumbnail == thumbnail &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        collectionId.hashCode ^
        description.hashCode ^
        price.hashCode ^
        discount_price.hashCode ^
        popularity.hashCode ^
        quantity.hashCode ^
        thumbnail.hashCode ^
        category.hashCode;
  }
}
