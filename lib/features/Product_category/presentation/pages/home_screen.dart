import 'package:apple_store/features/product_category/presentation/widgets/banner_slider.dart';
import 'package:apple_store/features/product_category/presentation/widgets/category_list.dart';
import 'package:apple_store/widgets/item_horizental_list.dart';
import 'package:apple_store/features/product_category/presentation/widgets/search_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SerchAppBar(),
          BannerSlider(),
          CategoryList(),
          ItemHorizentalList(),
          ItemHorizentalList(),
        ],
      ),
    );
  }
}
