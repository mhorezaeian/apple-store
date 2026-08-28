import 'package:apple_store/features/auth/data/datasources/authentication_data_source.dart';
import 'package:apple_store/features/auth/data/datasources/authentication_remote_data_source.dart';
import 'package:apple_store/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:apple_store/features/auth/data/repositories/authentication_repository.dart';
import 'package:apple_store/features/Product_category/data/datasources/Product_category_datasource.dart';
import 'package:apple_store/features/Product_category/data/datasources/Product_category_remote_datasource.dart';
import 'package:apple_store/features/Product_category/data/repositories/product_category_reposirory_impl.dart';
import 'package:apple_store/features/Product_category/data/repositories/product_category_reposirory.dart';
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
  locator.registerLazySingleton<AuthenticationDataSource>(
    () => AuthenticationRemoteDataSource(locator.get<Dio>()),
  );
  locator.registerLazySingleton<ProductCategoryDatasource>(
    () => ProductCategoryRemoteDatasource(locator.get<Dio>()),
  );

  //repository
  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(locator.get<AuthenticationDataSource>()),
  );
  locator.registerLazySingleton<ProductCategoryRepository>(
    () =>
        ProductCategoryReposiroryImpl(locator.get<ProductCategoryDatasource>()),
  );
}
