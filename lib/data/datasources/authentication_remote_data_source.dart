import 'package:apple_store/data/datasources/authentication_data_source.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/utils/api_exception.dart';
import 'package:dio/dio.dart';

class AuthenticationRemoteDataSource implements AuthenticationDataSource {
  final Dio _dio = locator.get();

  @override
  Future<void> register(
    String username,
    String password,
    String passwordConfirm,
  ) async {
    try {
      final response = await _dio.post(
        'collections/users/records',
        data: {
          'username': username,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );
      // print(response.data);
    } on DioException catch (e) {
      throw ApiException(
        code: e.response?.statusCode ?? 00,
        message: e.response?.data?.toString() ?? "error",
      );
    } catch (ex) {
      print('///////////////////error///////////');
      throw ApiException(code: 123, message: '${ex.toString()}');
    }
  }
}
