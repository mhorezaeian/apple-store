import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/core/di/di.dart';
import 'package:apple_store/core/widgets/falilure_state_widget.dart';
import 'package:apple_store/features/product/domain/entities/product.dart';
import 'package:apple_store/features/product/presentation/bloc/productList/product_list_bloc.dart';
import 'package:apple_store/features/product/presentation/widgets/product_card.dart';
import 'package:apple_store/features/product_category/domain/entities/product_category.dart';
import 'package:apple_store/widgets/product_app_bar.dart';
import 'package:apple_store/widgets/tittle_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatelessWidget {
  final ProductCategory productCategory;
  const ProductListScreen({super.key, required this.productCategory});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator.get<ProductListBloc>()
            ..add(ProductListStarted(categryId: productCategory.id!)),
      child: ShowProductListView(
        categoryId: productCategory.id!,
        categpryTitle: productCategory.name!,
      ),
    );
  }
}

class ShowProductListView extends StatelessWidget {
  final String categoryId;
  final String categpryTitle;
  const ShowProductListView({
    super.key,
    required this.categoryId,
    required this.categpryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolor.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<ProductListBloc, ProductlistState>(
          builder: (context, state) {
            if (state is ProductLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductListLoadSuccess) {
              return Column(
                children: [
                  ProductAppBar(title: '${categpryTitle}'),
                  Expanded(child: _ProductList(productList: state.products)),
                ],
              );
            } else if (state is ProductListLoadFailure) {
              return FailureStateWidget(
                message: state.message,
                onRetry: () {
                  context.read<ProductListBloc>().add(
                    ProductListRefreshed(categryId: categoryId),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class _ProductList extends StatelessWidget {
  List<Product> productList;
  _ProductList({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 44),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ProductCard(product: productList[index]);
              },
              childCount: productList.length, // ← این خط خیلی مهمه
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2 / 2.8,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
          ),
        ),
      ],
    );
  }
}
