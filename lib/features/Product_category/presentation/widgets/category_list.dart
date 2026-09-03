import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/features/product_category/presentation/widgets/category_item.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 44.0),
              child: Text(
                'دسته بندی',
                style: TextStyle(
                  fontFamily: 'sb',
                  fontSize: 12,
                  color: Mycolor.gery,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SizedBox(
                height: 90,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CategoryItem(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
