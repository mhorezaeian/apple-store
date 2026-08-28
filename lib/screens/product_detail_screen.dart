import 'dart:ui';

import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/widgets/product_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        dragStartBehavior: DragStartBehavior.start,
        slivers: [
          ProductAppBar(title: 'آیفون'),
          SliverToBoxAdapter(
            child: Text(
              'آیفون 12',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'sb', fontSize: 16),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 44.0,
                vertical: 20,
              ),
              child: Container(
                height: 284,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 15,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/icon_star.png'),
                            Text(
                              '4.6',
                              style: TextStyle(fontFamily: 'sm', fontSize: 12),
                            ),
                            Spacer(),
                            SizedBox(
                              height: double.infinity,
                              child: Image.asset('assets/images/iphone.png'),
                            ),
                            Spacer(),
                            Image.asset(
                              'assets/images/icon_favorite_deactive.png',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 70,
                                height: 70,
                                margin: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: Mycolor.gery,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset(
                                    'assets/images/iphone.png',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 44.0, right: 44, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "انتخاب رنگ",
                    style: TextStyle(fontFamily: 'sm', fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        width: 26,
                        height: 26,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        width: 26,
                        height: 26,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 44.0, right: 44, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "انتخاب حافظه داخلی",
                    style: TextStyle(fontFamily: 'sm', fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 26,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: BoxBorder.all(width: 1, color: Mycolor.gery),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 4,
                          ),
                          child: Text(
                            '128',
                            style: TextStyle(fontFamily: 'sb', fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        height: 26,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: BoxBorder.all(width: 1, color: Mycolor.gery),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 4,
                          ),
                          child: Text(
                            '128',
                            style: TextStyle(fontFamily: 'sb', fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        height: 26,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: BoxBorder.all(width: 1, color: Mycolor.gery),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 4,
                          ),
                          child: Text(
                            '128',
                            style: TextStyle(fontFamily: 'sb', fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 44.0,
                vertical: 10,
              ),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Mycolor.gery),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Image.asset('assets/images/icon_left_categroy.png'),
                      SizedBox(width: 5),
                      Text(
                        'مشاهده',
                        style: TextStyle(
                          fontFamily: 'sb',
                          fontSize: 12,
                          color: Mycolor.blue,
                        ),
                      ),
                      Spacer(),
                      Text(
                        ':مشخصات فنی',
                        style: TextStyle(fontFamily: 'sm', fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 44.0,
                vertical: 10,
              ),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Mycolor.gery),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Image.asset('assets/images/icon_left_categroy.png'),
                      SizedBox(width: 5),
                      Text(
                        'مشاهده',
                        style: TextStyle(
                          fontFamily: 'sb',
                          fontSize: 12,
                          color: Mycolor.blue,
                        ),
                      ),
                      Spacer(),
                      Text(
                        ':توضیحات محصول',
                        style: TextStyle(fontFamily: 'sm', fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 44.0,
                vertical: 10,
              ),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Mycolor.gery),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Image.asset('assets/images/icon_left_categroy.png'),
                      SizedBox(width: 5),
                      Text(
                        'مشاهده',
                        style: TextStyle(
                          fontFamily: 'sb',
                          fontSize: 12,
                          color: Mycolor.blue,
                        ),
                      ),
                      Spacer(),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red,
                            ),
                          ),
                          Positioned(
                            right: 15,
                            child: Container(
                              width: 26,
                              height: 26,
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 30,
                            child: Container(
                              width: 26,
                              height: 26,
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 45,
                            child: Container(
                              width: 26,
                              height: 26,
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 60,
                            child: Container(
                              width: 26,
                              height: 26,
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey,
                              ),
                              child: Center(
                                child: Text(
                                  '+10',
                                  style: TextStyle(
                                    fontFamily: 'sb',
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          ':نظرات کاربران',
                          style: TextStyle(fontFamily: 'sm', fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [priceButtom(), addToBasketButtom()],
            ),
          ),
        ],
      ),
    );
  }
}

class addToBasketButtom extends StatelessWidget {
  const addToBasketButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          width: 140,
          height: 60,
          decoration: BoxDecoration(
            color: Mycolor.blueIndicator,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SizedBox(
              width: 160,
              height: 53,
              child: Center(
                child: Text(
                  'افزودن به سبد خرید',
                  style: TextStyle(
                    fontFamily: 'sb',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class priceButtom extends StatelessWidget {
  const priceButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          width: 140,
          height: 60,
          decoration: BoxDecoration(
            color: Mycolor.green,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SizedBox(
              width: 160,
              height: 53,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 3.0,
                  vertical: 2,
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
                    Container(
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
