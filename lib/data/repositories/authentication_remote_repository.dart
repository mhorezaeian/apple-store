import 'package:apple_store/data/datasources/authentication_data_source.dart';
import 'package:apple_store/data/repositories/authentication_repository.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRemoteRepository implements AuthenticationRepository {
  final _datasource = locator.get<AuthenticationDataSource>();
  @override
  Future<Either<String, String>> register() async {
    try {
      await _datasource.register('uaaasername', '123456789', '123456789');
      return right('register done');
    } on ApiException catch (ex) {
      return left(ex.message ?? " خطا محتوای متنی ندارد");
    } catch (ex) {
      return left(ex.toString());
    }
  }
}
