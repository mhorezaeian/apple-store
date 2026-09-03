import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/features/product_category/presentation/widgets/category_item.dart';
import 'package:apple_store/widgets/tittle_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolor.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: TittleAppBar(title: 'حساب کاربری')),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(
                    'محمد حسین رضائیان',
                    style: TextStyle(fontFamily: 'sb', fontSize: 16),
                  ),
                  Text(
                    '09170427399',
                    style: TextStyle(
                      fontFamily: 'sm',
                      fontSize: 12,
                      color: Mycolor.gery,
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 44,
                vertical: 20,
              ),
              sliver: Directionality(
                textDirection: TextDirection.rtl,
                child: SliverGrid(
                  delegate: SliverChildBuilderDelegate(childCount: 10, (
                    context,
                    index,
                  ) {
                    return CategoryItem();
                  }),

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,

                    childAspectRatio: 1 / 1.2,
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
