// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:apple_store/features/product/domain/entities/product_property.dart';

//  {
//         "collectionId": "c66guhr3f15ow8f",
//         "collectionName": "properties",
//         "created": "2024-02-11 11:14:46.752Z",
//         "id": "yrgq8fo3vbwez0d",
//         "product_id": "at0y1gm0t65j62j",
//         "title": "حافظه داخلی",
//         "updated": "2024-02-11 11:22:52.564Z",
//         "value": "24 GB"
//     }

class ProductPropertyModel {
  String? id;
  String? product_id;
  String? title;
  String? value;

  ProductProperty toEntity() {
    return ProductProperty(
      id: id,
      product_id: product_id,
      title: title,
      value: value,
    );
  }

  ProductPropertyModel({this.id, this.product_id, this.title, this.value});

  ProductPropertyModel copyWith({
    String? id,
    String? product_id,
    String? title,
    String? value,
  }) {
    return ProductPropertyModel(
      id: id ?? this.id,
      product_id: product_id ?? this.product_id,
      title: title ?? this.title,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': product_id,
      'title': title,
      'value': value,
    };
  }

  factory ProductPropertyModel.fromMap(Map<String, dynamic> map) {
    return ProductPropertyModel(
      id: map['id'] != null ? map['id'] as String : null,
      product_id: map['product_id'] != null
          ? map['product_id'] as String
          : null,
      title: map['title'] != null ? map['title'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductPropertyModel.fromJson(String source) =>
      ProductPropertyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PropertyModel(id: $id, product_id: $product_id, title: $title, value: $value)';
  }

  @override
  bool operator ==(covariant ProductPropertyModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.product_id == product_id &&
        other.title == title &&
        other.value == value;
  }

  @override
  int get hashCode {
    return id.hashCode ^ product_id.hashCode ^ title.hashCode ^ value.hashCode;
  }
}
