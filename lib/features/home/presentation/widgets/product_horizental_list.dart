// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/features/product/domain/entities/product.dart';
import 'package:apple_store/features/product/presentation/widgets/product_card.dart';

class ProductHorizentalList extends StatelessWidget {
  String? title;
  List<Product>? productList;
  ProductHorizentalList({
    Key? key,
    required this.title,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 44.0, left: 44, bottom: 10),
              child: Row(
                children: [
                  Image.asset('assets/images/icon_left_categroy.png'),
                  SizedBox(width: 10),
                  Text(
                    'مشاهده همه',
                    style: TextStyle(
                      fontFamily: 'sb',
                      fontSize: 12,
                      color: Mycolor.blue,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '$title',
                    style: TextStyle(
                      fontFamily: 'sb',
                      fontSize: 12,
                      color: Mycolor.gery,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productList?.length,

                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ProductCard(product: productList![index]),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
