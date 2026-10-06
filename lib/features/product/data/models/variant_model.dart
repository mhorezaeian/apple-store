// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:apple_store/features/product/domain/entities/variant.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'variant_model.g.dart';

@HiveType(typeId: 1)
class VariantModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? type_id;
  @HiveField(2)
  String? product_id;
  @HiveField(3)
  String? name;
  @HiveField(4)
  int? price_change;
  @HiveField(5)
  String? value;
  VariantModel({
    this.id,
    this.type_id,
    this.product_id,
    this.name,
    this.price_change,
    this.value,
  });
  Variant toEntity() {
    return Variant(
      id: id,
      typeId: type_id,
      productId: product_id,
      name: name,
      priceChange: price_change,
      value: value,
    );
  }

  factory VariantModel.fromEntity(Variant entity) {
    return VariantModel(
      id: entity.id,
      type_id: entity.typeId,
      product_id: entity.productId,
      name: entity.name,
      price_change: entity.priceChange,
      value: entity.value,
    );
  }

  VariantModel copyWith({
    String? id,
    String? type_id,
    String? product_id,
    String? name,
    int? price_change,
    String? value,
  }) {
    return VariantModel(
      id: id ?? this.id,
      type_id: type_id ?? this.type_id,
      product_id: product_id ?? this.product_id,
      name: name ?? this.name,
      price_change: price_change ?? this.price_change,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type_id': type_id,
      'product_id': product_id,
      'name': name,
      'price_change': price_change,
      'value': value,
    };
  }

  factory VariantModel.fromMap(Map<String, dynamic> map) {
    return VariantModel(
      id: map['id'] != null ? map['id'] as String : null,
      type_id: map['type_id'] != null ? map['type_id'] as String : null,
      product_id: map['product_id'] != null
          ? map['product_id'] as String
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      price_change: map['price_change'] != null
          ? map['price_change'] as int
          : null,
      value: map['value'] != null ? map['value'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VariantModel.fromJson(String source) =>
      VariantModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VariantModel(id: $id, type_id: $type_id, product_id: $product_id, name: $name, price_change: $price_change, value: $value)';
  }

  @override
  bool operator ==(covariant VariantModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type_id == type_id &&
        other.product_id == product_id &&
        other.name == name &&
        other.price_change == price_change &&
        other.value == value;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type_id.hashCode ^
        product_id.hashCode ^
        name.hashCode ^
        price_change.hashCode ^
        value.hashCode;
  }
}

//json 
// {
//     "collectionId": "p09mlls67rzg1nu",
//     "collectionName": "variants",
//     "created": "2024-02-11 10:41:18.005Z",
//     "id": "ujlmfogbj1ecoqw",
//     "name": "سیاه",
//     "price_change": -40000,
//     "product_id": "at0y1gm0t65j62j",
//     "type_id": "t3kqbfnrz36g18k",
//     "updated": "2024-07-02 14:29:31.986Z",
//     "value": "000000"
// },