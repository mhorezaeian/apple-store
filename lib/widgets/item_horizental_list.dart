import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ItemHorizentalList extends StatelessWidget {
  const ItemHorizentalList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 44.0, left: 44, bottom: 10),
            child: Row(
              children: [
                Image.asset('assets/images/icon_left_categroy.png'),
                SizedBox(width: 10),
                Text(
                  'مشاهده همه',
                  style: TextStyle(
                    fontFamily: 'sb',
                    fontSize: 12,
                    color: Mycolor.blue,
                  ),
                ),
                Spacer(),
                Text(
                  'پرفروش ترین',
                  style: TextStyle(
                    fontFamily: 'sb',
                    fontSize: 12,
                    color: Mycolor.gery,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,

                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ProductCard(),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
