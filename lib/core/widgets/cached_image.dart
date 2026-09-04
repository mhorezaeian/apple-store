import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  String imageUrl;
  BoxFit fit;
  double radius;
  double? width;
  double? height;
  CachedImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.radius = 15,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(radius),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: fit,
        imageUrl: imageUrl,
        errorWidget: ((context, url, error) => Container(color: Colors.red)),
        placeholder: (context, url) => Container(color: Colors.grey),
      ),
    );
  }
}
