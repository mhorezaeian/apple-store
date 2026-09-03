import 'dart:ui';

import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/core/di/di.dart';
import 'package:apple_store/features/product_category/domain/repositories/product_category_reposirory.dart';
import 'package:apple_store/features/product_category/presentation/bloc/product_category_bloc.dart';
import 'package:apple_store/screens/product_category_screen.dart';
import 'package:apple_store/screens/basket_screen.dart';
import 'package:apple_store/features/product_category/presentation/pages/home_screen.dart';

import 'package:apple_store/screens/profile_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getItInit();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedScreen = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Mycolor.backgroundScreenColor,

        // body: LoginScreen(),
        body: IndexedStack(index: selectedScreen, children: getScreens()),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: BottomNavigationBar(
              onTap: (int index) {
                setState(() {
                  selectedScreen = index;
                });
              },
              currentIndex: selectedScreen,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedLabelStyle: const TextStyle(
                fontFamily: 'sb',
                fontSize: 10,
                color: Mycolor.blue,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'sb',
                fontSize: 10,
                color: Colors.black,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icon_profile.png'),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Mycolor.blue,
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 13),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/icon_profile_active.png',
                      ),
                    ),
                  ),
                  label: 'حساب کاربری',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icon_basket.png'),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Mycolor.blue,
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 13),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/icon_basket_active.png',
                      ),
                    ),
                  ),
                  label: 'سبد خرید',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icon_category.png'),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Mycolor.blue,
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 13),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/icon_category_active.png',
                      ),
                    ),
                  ),
                  label: 'دسته بندی',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icon_home.png'),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Mycolor.blue,
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 13),
                          ),
                        ],
                      ),
                      child: Image.asset('assets/images/icon_home_active.png'),
                    ),
                  ),
                  label: 'خانه',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> getScreens() {
  return <Widget>[
    ProfileScreen(),
    BasketScreen(),
    ProductCategoryScreen(),
    HomeScreen(),
  ];
}
