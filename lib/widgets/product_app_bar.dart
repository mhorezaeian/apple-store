import 'dart:math';

import 'package:flutter/material.dart';

class ProductAppBar extends StatelessWidget {
  ProductAppBar({super.key, required this.title, this.hPadding = 44});
  String title;
  double hPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: hPadding,
        right: hPadding,
        bottom: 10,
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
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Transform.rotate(
                    angle: pi,
                    child: Image.asset(
                      'assets/images/icon_left_categroy.png',
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
