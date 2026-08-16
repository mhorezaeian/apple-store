import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: ShapeDecoration(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(40),
            ),
            shadows: const [
              BoxShadow(
                color: Colors.red,
                blurRadius: 30,
                spreadRadius: -6,
                offset: Offset(0, 10),
              ),
            ],
            color: Colors.red,
          ),

          child: const Icon(Icons.apple, color: Colors.white, size: 30),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "اپل",
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
