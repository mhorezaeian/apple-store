import 'dart:convert';

import 'package:apple_store/features/home/domain/entities/banner.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BannerModel {
  String? id;
  String? collectionId;
  String? thumbnail;
  BannerModel({
    required this.id,
    required this.collectionId,
    required this.thumbnail,
  });

  BannerModel copyWith({String? id, String? collectionId, String? thumbnail}) {
    return BannerModel(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'collectionId': collectionId,
      'thumbnail': thumbnail,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] as String,
      collectionId: map['collectionId'] as String,
      thumbnail:
          'https://startflutter.ir/api/files/${map['collectionId'] as String}/${map['id'] as String}/${map['thumbnail'] as String}',
    );
  }
  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BannerModel(id: $id, collectionId: $collectionId, thumbnail: $thumbnail)';

  @override
  bool operator ==(covariant BannerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.collectionId == collectionId &&
        other.thumbnail == thumbnail;
  }

  @override
  int get hashCode => id.hashCode ^ collectionId.hashCode ^ thumbnail.hashCode;

  Banner toEntity() {
    return Banner(id: id ?? '', imageUrl: thumbnail ?? '');
  }
}


            // "categoryId": "dekzzpsz4gx97xr",
            // "collectionId": "y1ycamvhnld90us",
            // "collectionName": "banner",
            // "created": "2023-12-29 14:39:11.330Z",
            // "id": "cz7zqdbc7km1e66",
            // "thumbnail": "rectangle_10_2qTfXOTZWt.png",
            // "updated": "2023-12-29 14:39:11.330Z"
