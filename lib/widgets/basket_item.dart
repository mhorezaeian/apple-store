import 'package:apple_store/constants/myColor.dart';
import 'package:flutter/material.dart';

class BasketItem extends StatelessWidget {
  const BasketItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 44.0, right: 44, bottom: 20),
      child: Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                'آیفون 13 پرومکس دوسیم کارت',
                                style: TextStyle(
                                  fontFamily: 'sb',
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              'گارانتی 18 ماهه مدیا پردازش ',
                              style: TextStyle(fontFamily: 'sm', fontSize: 12),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  // width: 30,
                                  // height: 17,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.red,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 1,
                                      horizontal: 6,
                                    ),
                                    child: Text(
                                      '%3',
                                      style: TextStyle(
                                        fontFamily: 'sm',
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3),
                                Text(
                                  'تومان',
                                  style: TextStyle(
                                    fontFamily: 'sm',
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: 3),

                                Text(
                                  '46,000,000',
                                  style: TextStyle(
                                    fontFamily: 'sm',
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: BoxBorder.all(
                                        width: 1,
                                        color: Mycolor.gery,
                                      ),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/icon_options.png',
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 4.0,
                                                  ),
                                              child: Text(
                                                'سبز کله غازی',
                                                style: TextStyle(
                                                  fontFamily: 'sm',
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),

                                            Container(
                                              width: 15,
                                              height: 15,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: BoxBorder.all(
                                        width: 1,
                                        color: Mycolor.gery,
                                      ),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/icon_options.png',
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 4.0,
                                              ),
                                              child: Text(
                                                '256 گیگابایت',
                                                style: TextStyle(
                                                  fontFamily: 'sm',
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: BoxBorder.all(
                                        width: 1,
                                        color: Mycolor.gery,
                                      ),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 5.0,
                                                  ),
                                              child: Text(
                                                'حذف',
                                                style: TextStyle(
                                                  fontFamily: 'sm',
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),

                                            Image.asset(
                                              'assets/images/icon_trash.png',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: BoxBorder.all(
                                        width: 1,
                                        color: Mycolor.gery,
                                      ),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 5.0,
                                                  ),
                                              child: Text(
                                                'ذخیره',
                                                style: TextStyle(
                                                  fontFamily: 'sm',
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),

                                            Image.asset(
                                              'assets/images/active_fav_product.png',
                                              width: 15,
                                              height: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: BoxBorder.all(
                                        width: 1,
                                        color: Mycolor.gery,
                                      ),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 9.0,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/icon_options.png',
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 4.0,
                                              ),
                                              child: Text(
                                                '1',
                                                style: TextStyle(
                                                  fontFamily: 'sm',
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Image.asset('assets/images/iphone.png'),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(thickness: 0.8, indent: 2, endIndent: 2),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'تومان',
                      style: TextStyle(fontFamily: 'sb', fontSize: 16),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '54,350,000',
                      style: TextStyle(fontFamily: 'sb', fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
