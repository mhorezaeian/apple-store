// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:apple_store/features/product_category/domain/entities/product_category.dart';

class ProductCategoryModel {
  String? id;
  String? collectionId;
  String? color;
  String? icon;
  String? thumbnail;
  String? title;
  ProductCategoryModel({
    required this.id,
    required this.collectionId,
    required this.color,
    required this.icon,
    required this.thumbnail,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'collectionId': collectionId,
      'color': color,
      'icon': icon,
      'thumbnail': thumbnail,
      'title': title,
    };
  }

  factory ProductCategoryModel.fromMap(Map<String, dynamic> map) {
    return ProductCategoryModel(
      id: map['id'] as String,
      collectionId: map['collectionId'] as String,
      color: map['color'] as String,
      icon:
          'https://startflutter.ir/api/files/${map['collectionId'] as String}/${map['id'] as String}/${map['icon'] as String}',
      thumbnail:
          'https://startflutter.ir/api/files/${map['collectionId'] as String}/${map['id'] as String}/${map['thumbnail'] as String}',
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCategoryModel.fromJson(String source) =>
      ProductCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ProductCategory toEntity() {
    return ProductCategory(
      id: id ?? '',
      name: title ?? '',
      imageUrl: thumbnail ?? '',
      color: color ?? '',
      iconUrl: icon ?? '',
    );
  }
}
