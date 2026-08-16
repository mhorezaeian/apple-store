import 'package:apple_store/constants/myColor.dart';
import 'package:apple_store/widgets/product_card.dart';
import 'package:apple_store/widgets/tittle_app_bar.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolor.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            TittleAppBar(title: 'لیست محصولات'),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ProductCard();
                }),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2 / 2.8,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
