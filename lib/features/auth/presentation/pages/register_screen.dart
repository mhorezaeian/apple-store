import 'package:apple_store/core/utils/autth_manager.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // var either = await AuthenticationRepositoryImpl().register(
                //   'liusername',
                //   '123456789',
                //   '123456789',
                // );
                // either.fold(
                //   (left) {
                //     print(left);
                //   },
                //   (right) {
                //     print(right);
                //   },
                // );
              },

              child: Text('ثبت نام'),
            ),
            ElevatedButton(
              onPressed: () async {
                // var either = await AuthenticationRepositoryImpl().login(
                //   'liusername',
                //   '123456789',
                // );
                // either.fold(
                //   (left) {
                //     print(left);
                //   },
                //   (right) {
                //     print('///////////access_token/////////////');
                //     print(AuthManager.readToken());
                //     print(right);
                //   },
                // );
              },

              child: Text('ورود'),
            ),
            ElevatedButton(
              onPressed: () async {
                AuthManager.logout();
                print('///////////access_token/////////////');
                print(AuthManager.readToken());
              },

              child: Text('خروج'),
            ),
            ValueListenableBuilder(
              valueListenable: AuthManager.authChangeNotifier,
              builder: (context, value, child) {
                if (value == false) {
                  return Text(
                    'شما وارد نشده اید',
                    style: TextStyle(fontSize: 20),
                  );
                } else {
                  return Text(
                    'شما وارد شده اید',
                    style: TextStyle(fontSize: 20),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
