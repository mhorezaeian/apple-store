import 'package:apple_store/constants/myColor.dart';
import 'package:apple_store/widgets/tittle_app_bar.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolor.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            TittleAppBar(title: 'دسته بندی محولات'),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  );
                }),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
