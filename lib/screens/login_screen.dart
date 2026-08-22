import 'package:apple_store/constants/myColor.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;
    final isKeyboardOpen = keyboardHeight > 0;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Mycolor.blue,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final logoHeight = isKeyboardOpen
                  ? 100.0
                  : constraints.maxHeight * 0.4;
              return SingleChildScrollView(
                // controller: controller,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                        height: logoHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/icon_application.png',
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'اپل شاپ',
                              style: TextStyle(
                                fontFamily: 'sb',
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // height: 300,
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,

                          children: [
                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: 'نام کاربری',
                                labelStyle: TextStyle(
                                  fontFamily: 'sm',
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                hintText: '@AppleShop',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Mycolor.blue,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'رمز عبور',
                                labelStyle: TextStyle(
                                  fontFamily: 'sm',
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                hintText: '123456789',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Mycolor.blue,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(
                                  fontFamily: 'sb',
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                                backgroundColor: Mycolor.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    20,
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Text('ورود به حساب کاربری'),
                            ),
                            SizedBox(height: 10),

                            Divider(),
                            SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('ثبت نام'),

                                Text('فراموشی رمز عبور'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// page(usernameController: usernameController, passwordController: passwordController)
class page extends StatelessWidget {
  const page({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icon_application.png',
                  width: 100,
                  height: 100,
                ),
                Text(
                  'اپل شاپ',
                  style: TextStyle(
                    fontFamily: 'sb',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'نام کاربری',
                    labelStyle: TextStyle(
                      fontFamily: 'sm',
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    hintText: '@AppleShop',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Mycolor.blue, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'رمز عبور',
                    labelStyle: TextStyle(
                      fontFamily: 'sm',
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    hintText: '123456789',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Mycolor.blue, width: 2),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: Text('ورود')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
