import 'package:apple_store/data/datasources/authentication_data_source.dart';
import 'package:apple_store/data/datasources/authentication_remote_data_source.dart';
import 'package:apple_store/data/repositories/authentication_remote_repository.dart';
import 'package:apple_store/data/repositories/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //componenets
  locator.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/')),
  );
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
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
