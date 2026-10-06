import 'package:apple_store/core/widgets/cached_image.dart';
import 'package:apple_store/features/product/presentation/pages/product_list_screen.dart';
import 'package:apple_store/features/product_category/domain/entities/product_category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final ProductCategory pCategory;

  const CategoryItem({super.key, required this.pCategory});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(14),
          splashColor: Color(int.parse('0xFF${pCategory.color}')),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductListScreen(productCategory: pCategory),
              ),
            );
          },
          child: Container(
            width: 56,
            height: 56,

            decoration: ShapeDecoration(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(40),
              ),
              shadows: [
                BoxShadow(
                  color: Color(int.parse('0xFF${pCategory.color}')),
                  blurRadius: 30,
                  spreadRadius: -6,
                  offset: const Offset(0, 10),
                ),
              ],
              color: Color(int.parse('0xFF${pCategory.color}')),
            ),
            child: Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CachedImage(
                  imageUrl: pCategory.iconUrl ?? '',
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
            pCategory.name ?? '',
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
