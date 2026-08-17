import 'package:apple_store/data/datasources/authentication_remote_data_source.dart';
import 'package:apple_store/data/repositories/authentication_remote_repository.dart';
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
                var either = await AuthenticationRemoteRepository().register(
                  'liusername',
                  '123456789',
                  '123456789',
                );
                either.fold(
                  (left) {
                    print(left);
                  },
                  (right) {
                    print(right);
                  },
                );
              },

              child: Text('ثبت نام'),
            ),
            ElevatedButton(
              onPressed: () async {
                var either = await AuthenticationRemoteRepository().login(
                  'liusername',
                  '123456789',
                );
                either.fold(
                  (left) {
                    print(left);
                  },
                  (right) {
                    print(right);
                    print('شما وارد شدید');
                  },
                );
              },

              child: Text('ورود'),
            ),
          ],
        ),
      ),
    );
  }
}
