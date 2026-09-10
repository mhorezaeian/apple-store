// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:apple_store/core/utils/price_formatter.dart';
import 'package:apple_store/core/widgets/cached_image.dart';
import 'package:flutter/material.dart';

import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/features/product/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  Product product;
  ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        width: 160,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Mycolor.blue,
              blurRadius: 20,
              spreadRadius: -20,
              offset: Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,

          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      alignment: AlignmentGeometry.center,
                      children: [
                        Container(),
                        Container(
                          height: 100,
                          child: CachedImage(
                            imageUrl: product.imsgeUrl ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            // width: 30,
                            // height: 17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 1,
                                horizontal: 6,
                              ),
                              child: Text(
                                '${PriceFormatter.discountPercent(product.price ?? 0, product.discount_price ?? 0)}%',
                                style: TextStyle(
                                  fontFamily: 'sm',
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Image.asset(
                            'assets/images/icon_favorite_deactive.png',
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      textAlign: TextAlign.end,
                      '${product.name}',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SM',
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 160,
              height: 63,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Mycolor.blue,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'تومان',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SM',
                      fontSize: 13,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${PriceFormatter.format(product.price ?? 0)}',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.white,
                          decorationThickness: 1.5,
                          color: Colors.white,
                          fontFamily: 'SM',
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '${PriceFormatter.format(product.real_price ?? 0)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SM',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/icon_right_arrow_cricle.png',
                    width: 25,
                    height: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
