// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:apple_store/core/constants/myColor.dart' show Mycolor;
import 'package:apple_store/core/widgets/cached_image.dart';
import 'package:apple_store/features/product/domain/entities/product_image.dart';
import 'package:apple_store/features/product/presentation/bloc/product_bloc.dart';

class GallaryWidget extends StatefulWidget {
  List<ProductImage> gallary;
  String imageUrl;
  String rate;
  GallaryWidget({
    Key? key,
    required this.gallary,
    required this.imageUrl,
    required this.rate,
  }) : super(key: key);

  @override
  State<GallaryWidget> createState() => _GallaryWidgetState();
}

class _GallaryWidgetState extends State<GallaryWidget> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44.0, vertical: 20),
      child: Container(
        height: 284,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Image.asset('assets/images/icon_star.png'),
                    Text(
                      '4.6',
                      style: TextStyle(fontFamily: 'sm', fontSize: 12),
                    ),
                    Spacer(),
                    SizedBox(
                      height: double.infinity,
                      child: CachedImage(
                        imageUrl: widget.gallary.length == 0
                            ? widget.imageUrl.toString()
                            : widget.gallary[selectedItem].imageUrl.toString(),

                        fit: BoxFit.contain,
                      ),
                    ),
                    Spacer(),
                    Image.asset('assets/images/icon_favorite_deactive.png'),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.builder(
                    itemCount: widget.gallary.length == 0
                        ? 1
                        : widget.gallary.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedItem = index;
                          });
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          margin: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Mycolor.gery),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),

                            child: CachedImage(
                              imageUrl: widget.gallary.length == 0
                                  ? widget.imageUrl.toString()
                                  : widget.gallary[index].imageUrl.toString(),
                              fit: BoxFit.contain,
                              radius: 0,
                            ),
                          ),
                        ),
                      );
                    },
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
