// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductCategory {
  String? id;
  String? collectionId;
  String? color;
  String? icon;
  String? thumbnail;
  String? title;
  ProductCategory({
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

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(
      id: map['id'] as String,
      collectionId: map['collectionId'] as String,
      color: map['color'] as String,
      icon: map['icon'] as String,
      thumbnail:
          'https://startflutter.ir/api/files/${map['collectionId'] as String}/${map['id'] as String}/${map['thumbnail'] as String}',
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCategory.fromJson(String source) =>
      ProductCategory.fromMap(json.decode(source) as Map<String, dynamic>);
}
