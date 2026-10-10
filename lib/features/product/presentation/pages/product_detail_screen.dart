// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:apple_store/features/basket/domain/entities/basket_item.dart';
import 'package:apple_store/features/basket/presentation/bloc/basket_bloc.dart';
import 'package:apple_store/features/product/domain/entities/product_detail.dart';
import 'package:apple_store/features/product/domain/entities/product_property.dart';
import 'package:apple_store/features/product/domain/entities/variant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/core/di/di.dart';
import 'package:apple_store/core/utils/price_formatter.dart';
import 'package:apple_store/core/widgets/cached_image.dart';
import 'package:apple_store/core/widgets/falilure_state_widget.dart';
import 'package:apple_store/features/product/domain/entities/Product_variant.dart';
import 'package:apple_store/features/product/presentation/bloc/productDetail/product_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator.get<ProductBloc>()
            ..add(ProductStarted(productId: productId, categryId: categryId)),
        ),

        BlocProvider(create: (_) => locator<BasketBloc>()),
      ],
      child: ShowProductDetailScreen(
        productId: productId,
        categryId: categryId,
      ),
    );
  }
}

//
class ShowProductDetailScreen extends StatefulWidget {
  final String productId;
  final String categryId;

  ShowProductDetailScreen({
    super.key,
    required this.productId,
    required this.categryId,
  });

  @override
  State<ShowProductDetailScreen> createState() =>
      _ShowProductDetailScreenState();
}

class _ShowProductDetailScreenState extends State<ShowProductDetailScreen> {
  //
  final Map<String, Variant> selectedVariants = {};

  bool _variantsInitialized = false;

  //
  void initializeSelectedVariants(List<ProductVariant> productVariants) {
    for (final productVariant in productVariants) {
      final variants = productVariant.variants;

      if (variants.isEmpty) continue;

      final typeId = productVariant.variantType?.id ?? variants.first.typeId;

      if (typeId == null) continue;

      selectedVariants.putIfAbsent(typeId, () => variants.first);
    }
  }

  List<String?> _selectedVariantIds() {
    return selectedVariants.values.map((variant) => variant.id).toList();
  }

  void _requestMatchingBasketItem() {
    context.read<BasketBloc>().add(
      BasketSingleItemRequested(
        productId: widget.productId,
        variantIds: _selectedVariantIds(),
      ),
    );
  }

  BasketItem _createBasketItemFromProduct(ProductDetail product) {
    return BasketItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      productId: product.id,
      name: product.name,
      price: product.price,
      discountPrice: product.discount_price,
      thumbnail: product.imsgeUrl,
      quantity: 1,
      variants: selectedVariants.values.toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listenWhen: (previous, current) => current is ProductLoadSuccess,
      listener: (context, state) {
        if (state is! ProductLoadSuccess) {
          return;
        }

        if (!_variantsInitialized) {
          setState(() {
            initializeSelectedVariants(state.productVariants);
            _variantsInitialized = true;
          });
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          _requestMatchingBasketItem();
        });
      },
      child: Scaffold(
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
                    ProductAppBar(title: 'محصول'),

                    Expanded(
                      child: FailureStateWidget(
                        message: state.message,
                        onRetry: () {
                          context.read<ProductBloc>().add(
                            ProductRefreshed(
                              productId: widget.productId,
                              categryId: widget.categryId,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              // if (state is ProductLoadSuccess) {
              //   // انتخاب پیش‌فرض واریانت‌ها، فقط یک‌بار
              //   if (!_variantsInitialized) {
              //     initializeSelectedVariants(state.productVariants);
              //     _variantsInitialized = true;

              //     WidgetsBinding.instance.addPostFrameCallback((_) {
              //       if (!mounted) return;

              //       context.read<BasketBloc>().add(
              //         BasketSingleItemRequested(
              //           productId: widget.productId,
              //           variantIds: selectedVariants.values
              //               .map((variant) => variant.id)
              //               .toList(),
              //         ),
              //       );
              //     });
              //   }

              //   return Column(
              //     children: [
              //       ProductAppBar(title: '${state.productCategory.name}'),

              //       Expanded(
              //         child: CustomScrollView(
              //           dragStartBehavior: DragStartBehavior.start,
              //           slivers: [
              //             SliverToBoxAdapter(
              //               child: Text('${state.product.name}'),
              //             ),

              //             SliverToBoxAdapter(
              //               child: GallaryWidget(
              //                 imageUrl: state.product.imsgeUrl!,
              //                 gallary: state.productGallery,
              //                 rate: state.product.popularity ?? '1.1',
              //               ),
              //             ),

              //             if (state.productVariants.isNotEmpty)
              //               SliverToBoxAdapter(
              //                 child: Column(
              //                   children: state.productVariants.map((
              //                     productVariant,
              //                   ) {
              //                     // شناسه گروه واریانت
              //                     final typeId =
              //                         productVariant.variantType?.id ??
              //                         (productVariant.variants.isNotEmpty
              //                             ? productVariant.variants.first.typeId
              //                             : null);

              //                     return ProductVariantWidget(
              //                       productVariant: productVariant,

              //                       // شناسه واریانت انتخاب‌شده در این گروه
              //                       selectedVariantId: typeId == null
              //                           ? null
              //                           : selectedVariants[typeId]?.id,

              //                       // هنگام انتخاب رنگ، حافظه یا سایر ویژگی‌ها
              //                       onVariantSelected: (variant) {
              //                         final selectedTypeId =
              //                             variant.typeId ?? typeId;

              //                         if (selectedTypeId == null ||
              //                             variant.id == null) {
              //                           return;
              //                         }

              //                         setState(() {
              //                           selectedVariants[selectedTypeId] =
              //                               variant;
              //                         });

              //                         // جست‌وجوی همین ترکیب در سبد خرید
              //                         context.read<BasketBloc>().add(
              //                           BasketSingleItemRequested(
              //                             productId: widget.productId,
              //                             variantIds: selectedVariants.values
              //                                 .map((variant) => variant.id)
              //                                 .toList(),
              //                           ),
              //                         );
              //                       },
              //                     );
              //                   }).toList(),
              //                 ),
              //               ),

              //             // سایر بخش‌های مشخصات و توضیحات محصول را
              //             // مثل قبل در این قسمت نگه دار.
              //           ],
              //         ),
              //       ),

              //       // بخش پایینی قیمت و دکمه سبد خرید
              //       // فعلاً مثل کد قبلی خودت باقی بماند.
              //     ],
              //   );
              // }

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
                                  // شناسه گروه واریانت
                                  final typeId =
                                      productVariant.variantType?.id ??
                                      (productVariant.variants.isNotEmpty
                                          ? productVariant.variants.first.typeId
                                          : null);

                                  return ProductVariantWidget(
                                    productVariant: productVariant,

                                    // شناسه واریانت انتخاب‌شده در این گروه
                                    selectedVariantId: typeId == null
                                        ? null
                                        : selectedVariants[typeId]?.id,

                                    // هنگام انتخاب رنگ، حافظه یا سایر ویژگی‌ها
                                    onVariantSelected: (variant) {
                                      final selectedTypeId =
                                          variant.typeId ?? typeId;

                                      if (selectedTypeId == null ||
                                          variant.id == null) {
                                        return;
                                      }

                                      setState(() {
                                        selectedVariants[selectedTypeId] =
                                            variant;
                                      });

                                      _requestMatchingBasketItem();
                                    },
                                  );
                                }).toList(),
                              ),
                            ),

                          // SliverToBoxAdapter(
                          //   child: Column(
                          //     children: state.productVariants.map((
                          //       productVariant,
                          //     ) {
                          //       return ProductVariantWidget(
                          //         productVariant: productVariant,

                          //       );
                          //     }).toList(),
                          //   ),
                          // ),
                          SliverToBoxAdapter(
                            child: _showProductProperties(
                              productProperties: state.productProprtiers,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: _showProductDetail(
                              productDetail: state.product.description,
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                        ),
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
                        children: [
                          priceButtom(
                            price: state.product.price,
                            real_price: state.product.real_price,
                            discount_price: state.product.discount_price,
                          ),
                          BlocBuilder<BasketBloc, BasketState>(
                            buildWhen: (previous, current) =>
                                current is SingleBasketItemSuccess ||
                                current is SingleBasketItemFailure ||
                                current is BasketInitial ||
                                current is BasketError,
                            builder: (context, basketState) {
                              BasketItem? lineItem;
                              if (basketState is SingleBasketItemSuccess) {
                                lineItem = basketState.item;
                              }

                              final quantity = lineItem?.quantity ?? 0;
                              if (lineItem == null || quantity < 1) {
                                return AddToBasketButton(
                                  onPressed: () {
                                    context.read<BasketBloc>().add(
                                      BasketItemAdded(
                                        _createBasketItemFromProduct(
                                          state.product,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }

                              return ProductDetailQuantityControls(
                                quantity: quantity,
                                onIncrement: () {
                                  context.read<BasketBloc>().add(
                                    BasketItemAdded(
                                      BasketItem(
                                        productId: lineItem!.productId,
                                        name: lineItem.name,
                                        price: lineItem.price,
                                        discountPrice: lineItem.discountPrice,
                                        thumbnail: lineItem.thumbnail,
                                        quantity: 1,
                                        variants: lineItem.variants,
                                      ),
                                    ),
                                  );
                                },
                                onDecrement: () {
                                  final currentQuantity =
                                      lineItem!.quantity ?? 1;
                                  final itemId = lineItem.id;
                                  if (itemId == null) {
                                    return;
                                  }
                                  if (currentQuantity <= 1) {
                                    context.read<BasketBloc>().add(
                                      BasketItemRemoved(itemId),
                                    );
                                    return;
                                  }
                                  context.read<BasketBloc>().add(
                                    BasketItemUpdated(
                                      BasketItem(
                                        id: lineItem.id,
                                        productId: lineItem.productId,
                                        name: lineItem.name,
                                        price: lineItem.price,
                                        discountPrice: lineItem.discountPrice,
                                        thumbnail: lineItem.thumbnail,
                                        quantity: currentQuantity - 1,
                                        variants: lineItem.variants,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _showProductDetail extends StatefulWidget {
  String? productDetail;
  _showProductDetail({super.key, required this.productDetail});

  @override
  State<_showProductDetail> createState() => _showProductDetailState();
}

class _showProductDetailState extends State<_showProductDetail> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44.0, vertical: 5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
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
          SizedBox(height: 10),
          Visibility(
            visible: _isVisible,
            child: Container(
              // height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Mycolor.gery),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 12,
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    widget.productDetail ?? '',
                    style: TextStyle(
                      fontFamily: 'sm',
                      fontSize: 14,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _showProductProperties extends StatefulWidget {
  List<ProductProperty> productProperties;
  _showProductProperties({super.key, required this.productProperties});

  @override
  State<_showProductProperties> createState() => _showProductPropertiesState();
}

class _showProductPropertiesState extends State<_showProductProperties> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44.0, vertical: 5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
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
                      ': مشخصات فنی',
                      style: TextStyle(fontFamily: 'sm', fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Visibility(
            visible: _isVisible,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Mycolor.gery),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 8,
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child:
                      widget.productProperties == null ||
                          widget.productProperties!.isEmpty
                      ? Container(
                          width: double.infinity,
                          child: Text(
                            "مشخصاتی فنی برای این محصول ثبت نشه است",
                            style: TextStyle(fontFamily: 'sm', fontSize: 12),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: widget.productProperties!.map((prop) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 12,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // ستون عنوان
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${prop.title?.toString()}:" ?? "",
                                      style: const TextStyle(
                                        // fontWeight: FontWeight.w600,
                                        fontFamily: 'sm',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // ستون مقدار
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      prop.value?.toString() ?? "",
                                      textAlign:
                                          TextAlign.left, // یا TextAlign.start
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductVariantWidget extends StatelessWidget {
  final ProductVariant productVariant;
  final String? selectedVariantId;
  final ValueChanged<Variant> onVariantSelected;

  const ProductVariantWidget({
    super.key,
    required this.productVariant,
    required this.selectedVariantId,
    required this.onVariantSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isColor = productVariant.variantType?.type?.toLowerCase() == 'color';

    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType?.title ?? 'ویژگی محصول',
            style: const TextStyle(fontFamily: 'sm', fontSize: 12),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: productVariant.variants.map((variant) {
              final isSelected = variant.id == selectedVariantId;

              final Color variantColor = isColor
                  ? Color(
                      int.parse(
                        'FF${(variant.value ?? 'FFFFFF').replaceAll('#', '')}',
                        radix: 16,
                      ),
                    )
                  : Colors.white;

              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    onVariantSelected(variant);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: variantColor,
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          variant.name ?? '',
                          style: TextStyle(
                            fontFamily: 'sm',
                            fontSize: 13,
                            // color: Colors.black,
                            color: isColor ? Colors.white : Colors.black,
                          ),
                        ),
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

// class ProductVariantWidget extends StatelessWidget {
//   final ProductVariant productVariant;
//   ProductVariantWidget({Key? key, required this.productVariant})
//     : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 44.0, right: 44, bottom: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(
//             productVariant.variantType?.title ?? 'ویژگی محصول',
//             style: TextStyle(fontFamily: 'sm', fontSize: 12),
//           ),
//           SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: productVariant.variants.map((variant) {
//               final isColor =
//                   productVariant.variantType!.type!.toLowerCase() == 'color';

//               return Container(
//                 // width: 26,
//                 height: 26,
//                 margin: const EdgeInsets.only(left: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: isColor
//                       ? Color(int.parse('FF${variant.value}', radix: 16))
//                       : Colors.white,
//                 ),
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Text(
//                       variant.name!,
//                       style: TextStyle(
//                         fontFamily: 'sm',
//                         fontSize: 13,
//                         color: isColor ? Colors.white : Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

class AddToBasketButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddToBasketButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
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
      ),
    );
  }
}

class ProductDetailQuantityControls extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ProductDetailQuantityControls({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _QuantityIconButton(
                    icon: Icons.remove,
                    onPressed: onDecrement,
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(
                      fontFamily: 'sb',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  _QuantityIconButton(icon: Icons.add, onPressed: onIncrement),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _QuantityIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white24,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

class priceButtom extends StatelessWidget {
  int? price;
  int? discount_price;
  int? real_price;
  priceButtom({
    Key? key,
    required this.price,
    required this.discount_price,
    required this.real_price,
  }) : super(key: key);

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
                          '${PriceFormatter.format(price ?? 0)}',
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
                          '${PriceFormatter.format(real_price ?? 0)}',
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
                          '${PriceFormatter.discountPercent(price ?? 0, discount_price ?? 0)}%',
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
