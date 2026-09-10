// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:apple_store/features/product/domain/entities/product.dart';

// {
//     "category": "0fml1qqa0q17pk2",
//     "collectionId": "6s4mxhn1b9v0u2g",
//     "collectionName": "products",
//     "created": "2023-12-29 13:23:51.531Z",
//     "description": "asd fasdf asdf asd fad fads fasd fasdfadadsfadfasdfadsfafadsfasdf adsf",
//     "discount_price": 2000000,
//     "id": "p4ah0vfcb3joeju",
//     "name": "Apple Watch Series8",
//     "popularity": "Hotest",
//     "price": 38000000,
//     "quantity": 1,
//     "thumbnail": "applewatch8_6pcWJmYR22.jpg",
//     "updated": "2024-09-05 09:17:57.474Z"
// },

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
  });

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      discount_price: discount_price,
      popularity: popularity,
      quantity: quantity,
      imsgeUrl: thumbnail,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, collectionId: $collectionId, description: $description, price: $price, discount_price: $discount_price, popularity: $popularity, quantity: $quantity, thumbnail: $thumbnail)';
  }
}
