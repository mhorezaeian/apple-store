import 'dart:ui';
import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/core/di/di.dart';
import 'package:apple_store/features/product_category/presentation/pages/product_category_screen.dart';
import 'package:apple_store/features/basket/presentation/bloc/BasketBloc/basket_bloc.dart';
import 'package:apple_store/features/basket/presentation/pages/basket_screen.dart';
import 'package:apple_store/features/home/presentation/pages/home_screen.dart';

import 'package:apple_store/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:apple_store/core/services/deep_link_service.dart';
import 'package:apple_store/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:apple_store/features/payment/presentation/widgets/payment_effects_listener.dart';

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
  int selectedScreen = 3;
  late final BasketBloc _basketBloc;
  late final PaymentBloc _paymentBloc;
  late final DeepLinkService _deepLinkService;

  @override
  void initState() {
    super.initState();
    _basketBloc = locator<BasketBloc>()..add(const BasketStarted());
    _paymentBloc = locator<PaymentBloc>();

    // listener لینک پرداخت فقط یک‌بار و در ریشه ثبت می‌شود (نه داخل BasketScreen)،
    // چون اگر اپ با لینک باز شود، آن صفحه شاید هنوز ساخته نشده باشد.
    // از context استفاده نمی‌کنیم؛ مستقیم به Bloc می‌دهیم.
    _deepLinkService = locator<DeepLinkService>()
      ..init((authority, status) {
        _paymentBloc.add(
          PaymentCallbackReceived(authority: authority, status: status),
        );
      });
  }

  @override
  void dispose() {
    _deepLinkService.dispose();
    _paymentBloc.close();
    _basketBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _basketBloc),
        BlocProvider.value(value: _paymentBloc),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // PaymentEffectsListener دور Scaffold: بالاتر از IndexedStack (مستقل از تب)
        // و زیر Navigator (برای دیالوگ و push)
        home: PaymentEffectsListener(
          child: Scaffold(
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
                    if (index == 1) {
                      _basketBloc.add(const BasketRefreshed());
                    }
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
                          child: Image.asset(
                            'assets/images/icon_home_active.png',
                          ),
                        ),
                      ),
                      label: 'خانه',
                    ),
                  ],
                ),
              ),
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
