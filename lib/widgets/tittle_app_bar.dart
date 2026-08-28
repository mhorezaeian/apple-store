import 'package:apple_store/core/constants/myColor.dart';
import 'package:flutter/material.dart';

class TittleAppBar extends StatelessWidget {
  TittleAppBar({super.key, required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 44.0,
          right: 44,
          bottom: 20,
          top: 12,
        ),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Image.asset('assets/images/icon_apple_blue.png'),

                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'sb',
                      fontSize: 16,
                      color: Mycolor.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
