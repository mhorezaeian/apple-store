import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/core/utils/autth_manager.dart';
import 'package:apple_store/features/auth/data/datasources/authentication_data_source.dart';
import 'package:apple_store/features/auth/domain/repositories/authentication_repository.dart';

import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDataSource _datasource;

  AuthenticationRepositoryImpl(this._datasource);

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
        AuthManager.saveToken(token);
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
