//product_category
import 'package:apple_store/features/home/data/datasources/banner_datasource.dart';
import 'package:apple_store/features/home/data/datasources/banner_remote_dataSource.dart';
import 'package:apple_store/features/home/data/repositories/banner_repository_impl.dart';
import 'package:apple_store/features/home/domain/repositories/banner_repository.dart';
import 'package:apple_store/features/product_category/domain/repositories/product_category_reposirory.dart';
import 'package:apple_store/features/product_category/presentation/bloc/product_category_bloc.dart';
import 'package:apple_store/features/product_category/data/datasources/product_category_datasource.dart';
import 'package:apple_store/features/product_category/data/datasources/product_category_remote_datasource.dart';
import 'package:apple_store/features/product_category/data/repositories/product_category_reposirory_impl.dart';
//auth
import 'package:apple_store/features/auth/data/datasources/authentication_data_source.dart';
import 'package:apple_store/features/auth/data/datasources/authentication_remote_data_source.dart';
import 'package:apple_store/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:apple_store/features/auth/domain/repositories/authentication_repository.dart';
//
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  await _registerCorecomponenets();
  _registerAuthentication();
  _registerProductCategory();
  _registerHome();
}

Future<void> _registerCorecomponenets() async {
  //componenets
  locator.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/')),
  );
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
}

//
void _registerAuthentication() {
  //datasources
  locator.registerLazySingleton<AuthenticationDataSource>(
    () => AuthenticationRemoteDataSource(locator.get<Dio>()),
  );
  //repository
  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(locator.get<AuthenticationDataSource>()),
  );
}

//
void _registerProductCategory() {
  //datasources
  locator.registerFactory<ProductCategoryDatasource>(
    () => ProductCategoryRemoteDatasource(locator.get<Dio>()),
  );
  //repository
  locator.registerFactory<ProductCategoryRepository>(
    () =>
        ProductCategoryReposiroryImpl(locator.get<ProductCategoryDatasource>()),
  );
  //bloc
  locator.registerFactory<ProductCategoryBloc>(
    () => ProductCategoryBloc(locator.get<ProductCategoryRepository>()),
  );
}

//
void _registerHome() {
  //datasources
  locator.registerFactory<BannerDatasource>(
    () => BannerRemoteDatasource(locator.get<Dio>()),
  );

  //repository
  locator.registerFactory<BannerRepository>(
    () => BannerRepositoryImpl(locator.get<BannerDatasource>()),
  );

  //bloc
}
