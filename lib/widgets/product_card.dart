import 'package:apple_store/core/constants/myColor.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 216,
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
                      Image.asset('assets/images/iphone.png'),

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
                              '%3',
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
                    'آیفون 13 پرومکس',
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
                      '30,000,000',
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
                      '30,000,000',
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
    );
  }
}
