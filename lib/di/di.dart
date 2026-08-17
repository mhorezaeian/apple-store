import 'package:apple_store/data/datasources/authentication_data_source.dart';
import 'package:apple_store/data/datasources/authentication_remote_data_source.dart';
import 'package:apple_store/data/repositories/authentication_remote_repository.dart';
import 'package:apple_store/data/repositories/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  locator.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/')),
  );

  //datasources
  locator.registerFactory<AuthenticationDataSource>(
    () => AuthenticationRemoteDataSource(),
  );

  //repository
  locator.registerFactory<AuthenticationRepository>(
    () => AuthenticationRemoteRepository(),
  );
}
