import 'package:apple_store/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:apple_store/features/auth/presentation/bloc/auth_event.dart';
import 'package:apple_store/features/auth/presentation/bloc/auth_state.dart';
import 'package:apple_store/core/constants/myColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: ((context) => AuthBloc()), child: LoginView());
  }
}

class LoginView extends StatefulWidget {
  final _usernameController = TextEditingController(text: 'ssmamade12');
  final _passwordController = TextEditingController(text: '12345678');
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                            SizedBox(height: 10),
                            TextField(
                              controller: widget._usernameController,
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
                              controller: widget._passwordController,
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

                            //bloc
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                Widget myContainer = Container();
                                if (state is AuthInitState) {
                                  myContainer = Container(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        textStyle: TextStyle(
                                          fontFamily: 'sb',
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Mycolor.blue,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(20),
                                        ),
                                      ),

                                      onPressed: () {
                                        BlocProvider.of<AuthBloc>(context).add(
                                          AuthLoginRequestEvent(
                                            username:
                                                widget._usernameController.text,
                                            password:
                                                widget._passwordController.text,
                                          ),
                                        );
                                      },
                                      child: Text('ورود به حساب کاربری'),
                                    ),
                                  );
                                  return myContainer;
                                }
                                if (state is AuthLodingState) {
                                  return CircularProgressIndicator();
                                }
                                if (state is AuthResponseState) {
                                  state.responce.fold(
                                    (ifLeft) {
                                      myContainer = Container(
                                        child: Column(
                                          children: [
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
                                                  borderRadius:
                                                      BorderRadiusGeometry.circular(
                                                        20,
                                                      ),
                                                ),
                                              ),

                                              onPressed: () {
                                                BlocProvider.of<AuthBloc>(
                                                  context,
                                                ).add(
                                                  AuthLoginRequestEvent(
                                                    username: widget
                                                        ._usernameController
                                                        .text,
                                                    password: widget
                                                        ._passwordController
                                                        .text,
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'ورود به حساب کاربری',
                                              ),
                                            ),
                                            Text(ifLeft),
                                          ],
                                        ),
                                      );
                                      return myContainer;
                                    },
                                    (ifRight) {
                                      myContainer = Container(
                                        child: Column(
                                          children: [
                                            // ElevatedButton(
                                            //   style: ElevatedButton.styleFrom(
                                            //     textStyle: TextStyle(
                                            //       fontFamily: 'sb',
                                            //       fontSize: 20,
                                            //       color: Colors.white,
                                            //     ),
                                            //     backgroundColor: Mycolor.blue,
                                            //     foregroundColor: Colors.white,
                                            //     shape: RoundedRectangleBorder(
                                            //       borderRadius:
                                            //           BorderRadiusGeometry.circular(
                                            //             20,
                                            //           ),
                                            //     ),
                                            //   ),

                                            //   onPressed: () {
                                            //     BlocProvider.of<AuthBloc>(
                                            //       context,
                                            //     ).add(
                                            //       AuthLoginRequestEvent(
                                            //         username: widget
                                            //             ._usernameController
                                            //             .text,
                                            //         password: widget
                                            //             ._passwordController
                                            //             .text,
                                            //       ),
                                            //     );
                                            //   },
                                            //   child: Text(
                                            //     'ورود به حساب کاربری',
                                            //   ),
                                            // ),
                                            Text(ifRight),
                                          ],
                                        ),
                                      );
                                      return myContainer;
                                    },
                                  );
                                } else {
                                  myContainer = Container(
                                    child: Text('خطای نا مشخص رخ داد'),
                                  );
                                }
                                return myContainer;
                              },
                            ),

                            SizedBox(height: 10),

                            Divider(),
                            SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'ثبت نام',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'sm',
                                      color: Mycolor.blue,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'فراموشی رمز عبور',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'sm',
                                      color: Mycolor.blue,
                                    ),
                                  ),
                                ),
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
