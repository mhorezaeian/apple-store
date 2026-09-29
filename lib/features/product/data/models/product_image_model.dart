// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:apple_store/features/product/domain/entities/product_image.dart';

// {
//     "collectionId": "sxdtd1wwsdazvdl",
//     "collectionName": "gallery",
//     "created": "2024-01-24 18:20:05.197Z",
//     "id": "95ho71t6tb5i711",
//     "image": "macbook_png_image_1_hSRFFvN8a2.png",
//     "product_id": "78n4wqor3hhnkju",
//     "updated": "2024-01-24 18:20:05.197Z"
// },

class ProductImageModel {
  String? id;
  String? collectionId;
  String? product_id;
  String? image;
  ProductImageModel({this.id, this.collectionId, this.product_id, this.image});

  ProductImageModel copyWith({
    String? id,
    String? collectionId,
    String? product_id,
    String? image,
  }) {
    return ProductImageModel(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      product_id: product_id ?? this.product_id,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'collectionId': collectionId,
      'product_id': product_id,
      'image': image,
    };
  }

  factory ProductImageModel.fromMap(Map<String, dynamic> map) {
    return ProductImageModel(
      id: map['id'] != null ? map['id'] as String : null,
      collectionId: map['collectionId'] != null
          ? map['collectionId'] as String
          : null,
      product_id: map['product_id'] != null
          ? map['product_id'] as String
          : null,
      image:
          map['image'] != null &&
              map['collectionId'] != null &&
              map['id'] != null
          ? 'https://startflutter.ir/api/files/'
                '${map['collectionId']}/'
                '${map['id']}/'
                '${map['image']}'
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductImageModel.fromJson(String source) =>
      ProductImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductImageModel(id: $id, collectionId: $collectionId, product_id: $product_id, image: $image)';
  }

  @override
  bool operator ==(covariant ProductImageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.collectionId == collectionId &&
        other.product_id == product_id &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        collectionId.hashCode ^
        product_id.hashCode ^
        image.hashCode;
  }

  ProductImage toProductImageEntity() {
    return ProductImage(id: id, product_id: product_id, imageUrl: image);
  }
}
