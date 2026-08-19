import 'package:apple_store/data/datasources/authentication_data_source.dart';
import 'package:apple_store/data/repositories/authentication_repository.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/utils/api_exception.dart';
import 'package:dartz/dartz.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRemoteRepository implements AuthenticationRepository {
  final _datasource = locator.get<AuthenticationDataSource>();
  // final _sharedPref = locator.get<SharedPreferences>();
  @override
  Future<Either<String, String>> register(
    String username,
    String password,
    String passwordConfirm,
  ) async {
    try {
      await _datasource.register(username, password, passwordConfirm);
      return right('register done');
    } on ApiException catch (ex) {
      return left(ex.message ?? " خطا محتوای متنی ندارد");
    } catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      var token = await _datasource.login(username, password);
      if (token.isNotEmpty) {
        // _sharedPref.setString('access_token', token);
        return right('شما با موفقیت وارد شدید');
      } else {
        return left("خطاد");
      }
    } on ApiException catch (e) {
      return left(e.message ?? "خطا محتوای متنی ندارد");
    } catch (ex) {
      return left(ex.toString());
    }
  }
}
