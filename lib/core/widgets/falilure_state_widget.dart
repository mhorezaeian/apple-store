import 'package:apple_store/core/constants/myColor.dart';
import 'package:flutter/material.dart';

class FailureStateWidget extends StatelessWidget {
  final String message;

  final VoidCallback onRetry;
  FailureStateWidget({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(44.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'sm', fontSize: 13),
                ),
                SizedBox(height: 15),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Mycolor.blueIndicator,

                  onTap: () {
                    // print('object');
                    onRetry();
                  },
                  child: Container(
                    // width: 56,
                    // height: 56,
                    decoration: ShapeDecoration(
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(20),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Mycolor.blue,
                          blurRadius: 30,
                          spreadRadius: -6,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      color: Mycolor.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16,
                      ),
                      child: Text(
                        'تلاش مجدد',
                        style: TextStyle(
                          fontFamily: 'sb',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
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
