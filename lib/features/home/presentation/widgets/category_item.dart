import 'package:apple_store/core/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String name;
  final String color;
  final String iconUrl;
  const CategoryItem({
    super.key,
    required this.name,
    required this.color,
    required this.iconUrl,
  });

  @override
  Widget build(BuildContext context) {
    print(iconUrl);
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(14),
          splashColor: Color(int.parse('0xFF$color')),

          onTap: () {},
          child: Container(
            width: 56,
            height: 56,

            decoration: ShapeDecoration(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(40),
              ),
              shadows: [
                BoxShadow(
                  color: Color(int.parse('0xFF$color')),
                  blurRadius: 30,
                  spreadRadius: -6,
                  offset: const Offset(0, 10),
                ),
              ],
              color: Color(int.parse('0xFF$color')),
            ),
            child: Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CachedImage(
                  imageUrl: iconUrl,
                  fit: BoxFit.fill,

                  radius: 0,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'SB',
              // fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
