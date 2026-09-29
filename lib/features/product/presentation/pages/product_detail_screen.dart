// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:apple_store/features/product/domain/entities/Product_variant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/core/di/di.dart';
import 'package:apple_store/core/widgets/cached_image.dart';
import 'package:apple_store/core/widgets/falilure_state_widget.dart';
import 'package:apple_store/features/product/presentation/bloc/product_bloc.dart';
import 'package:apple_store/features/product/presentation/widgets/gallary_widget.dart';
import 'package:apple_store/widgets/product_app_bar.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  final String categryId;

  ProductDetailScreen({
    super.key,
    required this.productId,
    required this.categryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator.get<ProductBloc>()
            ..add(ProductStarted(productId: productId, categryId: categryId)),
      child: ShowProductDetailScreen(
        productId: productId,
        categryId: categryId,
      ),
    );
  }
}

class ShowProductDetailScreen extends StatelessWidget {
  final String productId;
  final String categryId;

  ShowProductDetailScreen({
    super.key,
    required this.productId,
    required this.categryId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolor.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            //
            if (state is ProductLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProductLoadFailure) {
              return Column(
                children: [
                  ProductAppBar(title: 'محصولر'),

                  Expanded(
                    child: FailureStateWidget(
                      message: state.message,
                      onRetry: () {
                        context.read<ProductBloc>().add(
                          ProductRefreshed(
                            productId: productId,
                            categryId: categryId,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            if (state is ProductLoadSuccess) {
              return Column(
                children: [
                  //app bar
                  ProductAppBar(title: '${state.productCategory.name}'),
                  Expanded(
                    child: CustomScrollView(
                      dragStartBehavior: DragStartBehavior.start,
                      slivers: [
                        //app bar
                        // SliverToBoxAdapter(
                        //   child:
                        // ),

                        //title
                        SliverToBoxAdapter(
                          child: Text(
                            '${state.product.name}',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'sb', fontSize: 16),
                          ),
                        ),

                        // product gallary
                        SliverToBoxAdapter(
                          child: GallaryWidget(
                            imageUrl: state.product.imsgeUrl!,
                            gallary: state.productGallery,
                            rate: state.product.popularity ?? '1.1',
                          ),
                        ),

                        // product detail
                        if (state.productVariants.isNotEmpty)
                          SliverToBoxAdapter(
                            child: Column(
                              children: state.productVariants.map((
                                productVariant,
                              ) {
                                return ProductVariantWidget(
                                  productVariant: productVariant,
                                );
                              }).toList(),
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
                                border: Border.all(
                                  width: 1,
                                  color: Mycolor.gery,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icon_left_categroy.png',
                                    ),
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
                                      style: TextStyle(
                                        fontFamily: 'sm',
                                        fontSize: 14,
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 44.0,
                              vertical: 10,
                            ),
                            child: Container(
                              height: 46,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Mycolor.gery,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icon_left_categroy.png',
                                    ),
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
                                      style: TextStyle(
                                        fontFamily: 'sm',
                                        fontSize: 14,
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 44.0,
                              vertical: 10,
                            ),
                            child: Container(
                              height: 46,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Mycolor.gery,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icon_left_categroy.png',
                                    ),
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
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                        style: TextStyle(
                                          fontFamily: 'sm',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SliverToBoxAdapter(
                        //   child:
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [priceButtom(), addToBasketButtom()],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class ProductVariantWidget extends StatelessWidget {
  final ProductVariant productVariant;
  ProductVariantWidget({Key? key, required this.productVariant})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('====> productVariant: ${productVariant.variantType.toString()}');
    print("====> productVariant: ${productVariant.variants.toString()}");
    return Padding(
      padding: const EdgeInsets.only(left: 44.0, right: 44, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType?.title ?? 'ویژگی محصول',
            style: TextStyle(fontFamily: 'sm', fontSize: 12),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: productVariant.variants.map((variant) {
              final isColor =
                  productVariant.variantType!.type!.toLowerCase() == 'color';

              return Container(
                // width: 26,
                height: 26,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isColor
                      ? Color(int.parse('FF${variant.value}', radix: 16))
                      : Colors.white,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      variant.name!,
                      style: TextStyle(
                        fontFamily: 'sm',
                        fontSize: 13,
                        color: isColor ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
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
