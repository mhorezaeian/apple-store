// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:apple_store/features/product/domain/entities/variant_type.dart';

//
// {
//     "collectionId": "mk6un6za8uwi5g2",
//     "collectionName": "variants_type",
//     "created": "2024-02-11 10:37:38.564Z",
//     "id": "t3kqbfnrz36g18k",
//     "name": "شارژر بی سیم اپل",
//     "title": "انتخاب رنگ",
//     "type": "Color",
//     "updated": "2024-09-06 07:52:52.006Z"
// },

class VariantTypeModel {
  String? id;
  String? name;
  String? title;
  String? type;
  VariantTypeModel({this.id, this.name, this.title, this.type});

  VariantType toEntity() {
    return VariantType(id: id, name: name, title: title, type: type);
  }

  VariantTypeModel copyWith({
    String? id,
    String? name,
    String? title,
    String? type,
  }) {
    return VariantTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'title': title,
      'type': type,
    };
  }

  factory VariantTypeModel.fromMap(Map<String, dynamic> map) {
    return VariantTypeModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VariantTypeModel.fromJson(String source) =>
      VariantTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VariantsTypeModel(id: $id, name: $name, title: $title, type: $type)';
  }

  @override
  bool operator ==(covariant VariantTypeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.title == title &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ title.hashCode ^ type.hashCode;
  }
}
