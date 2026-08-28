import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/widgets/basket_item.dart';
import 'package:apple_store/widgets/tittle_app_bar.dart';
import 'package:flutter/material.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CustomScrollView(
            slivers: [
              TittleAppBar(title: 'سبد خرید'),
              SliverList(
                delegate: SliverChildBuilderDelegate(childCount: 12, (
                  context,
                  index,
                ) {
                  return BasketItem();
                }),
              ),
              SliverPadding(padding: EdgeInsetsGeometry.only(bottom: 60)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44.0, vertical: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 53,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Mycolor.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(15),
                  ),
                ),

                child: Text(
                  'ادامه فرآیند خرید',
                  style: TextStyle(
                    fontFamily: 'sb',
                    fontSize: 16,
                    color: Colors.white,
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
