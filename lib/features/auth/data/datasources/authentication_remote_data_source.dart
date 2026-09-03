import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/features/auth/data/datasources/authentication_data_source.dart';
import 'package:dio/dio.dart';

class AuthenticationRemoteDataSource implements AuthenticationDataSource {
  final Dio _dio;

  AuthenticationRemoteDataSource(this._dio);

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
      throw ServerException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.data?.toString() ?? " API error",
        body: e.response?.data is Map
            ? Map<String, dynamic>.from(e.response!.data)
            : {},
      );
    } catch (ex) {
      print('///////////////////error///////////');
      throw ServerException(statusCode: 123, message: ex.toString());
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post(
        'collections/users/auth-with-password',
        data: {'identity': username, 'password': password},
      );
      if (response.statusCode == 200) {
        return response.data?['token'];
      } else {
        return "error on login";
      }
    } on DioException catch (ex) {
      throw ServerException(
        statusCode: ex.response?.statusCode ?? 000,
        message: ex.response?.data?.toString() ?? " error",
        body: ex.response?.data is Map
            ? Map<String, dynamic>.from(ex.response!.data)
            : {},
      );
    } catch (ex) {
      throw ServerException(statusCode: 123, message: ex.toString());
    }
  }
}
