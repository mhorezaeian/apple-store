//product_category
import 'package:apple_store/features/home/data/datasources/banner_datasource.dart';
import 'package:apple_store/features/home/data/datasources/banner_remote_dataSource.dart';
import 'package:apple_store/features/home/data/repositories/banner_repository_impl.dart';
import 'package:apple_store/features/home/domain/repositories/banner_repository.dart';
import 'package:apple_store/features/home/presentation/bloc/home_bloc.dart';
import 'package:apple_store/features/product/data/datasources/product_datasource.dart';
import 'package:apple_store/features/product/data/datasources/product_gallery_datasource.dart';
import 'package:apple_store/features/product/data/datasources/product_gallery_remote_datasource.dart';
import 'package:apple_store/features/product/data/datasources/product_remote_datasource.dart';
import 'package:apple_store/features/product/data/repositories/product_gallery_repository_impl.dart';

import 'package:apple_store/features/product/data/repositories/product_repository_impl.dart';
import 'package:apple_store/features/product/domain/repositories/product_gallery_repository.dart';
import 'package:apple_store/features/product/domain/repositories/product_repositiry.dart';
import 'package:apple_store/features/product/presentation/bloc/product_bloc.dart';
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
  _registerProduct();
}

//Core
Future<void> _registerCorecomponenets() async {
  //componenets
  locator.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/')),
  );
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
}

//Auth
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

//ProductCategory
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

//Home
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
  locator.registerFactory<HomeBloc>(
    () => HomeBloc(
      locator.get<BannerRepository>(),
      locator.get<ProductCategoryRepository>(),
      locator.get<ProductRepositiry>(),
    ),
  );
}

//Home
void _registerProduct() {
  //datasources
  locator.registerFactory<ProductDatasource>(
    () => ProductRemoteDatasource(locator.get<Dio>()),
  );
  //
  locator.registerFactory<ProductGalleryDatasource>(
    () => ProductGalleryRemoteDatasource(locator.get<Dio>()),
  );
  //poduct comments
  // locator.registerFactory<ProductDatasource>(
  //   () => ProductRemoteDatasource(locator.get<Dio>()),
  // );

  //repository
  locator.registerFactory<ProductRepositiry>(
    () => ProductRepositoryImpl(locator.get<ProductDatasource>()),
  );
  locator.registerFactory<ProductGalleryRepository>(
    () => ProductGalleryRepositoryImpl(locator.get<ProductGalleryDatasource>()),
  );

  //poduct comments
  // locator.registerFactory<ProductRepositiry>(
  //   () => ProductRepositoryImpl(locator.get<ProductDatasource>()),
  // );

  //bloc
  locator.registerFactory<ProductBloc>(
    () => ProductBloc(
      locator.get<ProductRepositiry>(),
      locator.get<ProductGalleryRepository>(),
    ),
  );
}
