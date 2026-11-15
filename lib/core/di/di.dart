//product_category
import 'package:apple_store/features/basket/data/datasources/basket_datasource.dart';
import 'package:apple_store/features/basket/data/datasources/basket_local_datasource.dart';
import 'package:apple_store/features/basket/data/models/basket_item_model.dart';
import 'package:apple_store/features/basket/data/repositories/basket_repository_impl.dart';
import 'package:apple_store/features/basket/domain/repositories/basket_repository.dart';
import 'package:apple_store/features/basket/domain/usecases/get_single_basket_item.dart';
import 'package:apple_store/features/basket/presentation/bloc/BasketBloc/basket_bloc.dart';
import 'package:apple_store/features/basket/presentation/bloc/ProductBasketBloc/product_basket_bloc.dart';
import 'package:apple_store/features/home/data/datasources/banner_datasource.dart';
import 'package:apple_store/features/home/data/datasources/banner_remote_dataSource.dart';
import 'package:apple_store/features/home/data/repositories/banner_repository_impl.dart';
import 'package:apple_store/features/home/domain/repositories/banner_repository.dart';
import 'package:apple_store/features/home/presentation/bloc/home_bloc.dart';
import 'package:apple_store/features/product/data/datasources/product_datasource.dart';
import 'package:apple_store/features/product/data/datasources/product_gallery_datasource.dart';
import 'package:apple_store/features/product/data/datasources/product_gallery_remote_datasource.dart';
import 'package:apple_store/features/product/data/datasources/product_property_datasource.dart';
import 'package:apple_store/features/product/data/datasources/product_property_remote_datasource.dart';
import 'package:apple_store/features/product/data/datasources/product_remote_datasource.dart';
import 'package:apple_store/features/product/data/models/variant_model.dart';
import 'package:apple_store/features/product/data/repositories/product_gallery_repository_impl.dart';
import 'package:apple_store/features/product/data/repositories/product_property_repository_impl.dart';

import 'package:apple_store/features/product/data/repositories/product_repository_impl.dart';
import 'package:apple_store/features/product/domain/repositories/product_gallery_repository.dart';
import 'package:apple_store/features/product/domain/repositories/product_property_repository.dart';
import 'package:apple_store/features/product/domain/repositories/product_repositiry.dart';
import 'package:apple_store/features/product/presentation/bloc/productDetail/product_bloc.dart';
import 'package:apple_store/features/product/presentation/bloc/productList/product_list_bloc.dart';
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
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:apple_store/features/basket/domain/usecases/add_to_basket.dart';
import 'package:apple_store/features/basket/domain/usecases/get_basket.dart';
import 'package:apple_store/features/basket/domain/usecases/update_basket_item.dart';
import 'package:apple_store/features/basket/domain/usecases/remove_from_basket.dart';
import 'package:apple_store/features/basket/domain/usecases/clear_basket.dart';

import 'package:apple_store/core/config/payment_config.dart';
import 'package:apple_store/core/services/deep_link_service.dart';
// orders
import 'package:apple_store/features/orders/data/datasources/order_datasource.dart';
import 'package:apple_store/features/orders/data/datasources/order_local_datasource.dart';
import 'package:apple_store/features/orders/data/models/order_model.dart';
import 'package:apple_store/features/orders/data/repositories/order_repository_impl.dart';
import 'package:apple_store/features/orders/domain/repositories/order_repository.dart';
import 'package:apple_store/features/orders/domain/usecases/get_orders.dart';
import 'package:apple_store/features/orders/domain/usecases/place_order.dart';
import 'package:apple_store/features/orders/presentation/bloc/orders_bloc.dart';
// payment
import 'package:apple_store/features/payment/data/datasources/payment_remote_datasource.dart';
import 'package:apple_store/features/payment/data/datasources/pending_payment_datasource.dart';
import 'package:apple_store/features/payment/data/datasources/pending_payment_local_datasource.dart';
import 'package:apple_store/features/payment/data/datasources/zarinpal_remote_datasource.dart';
import 'package:apple_store/features/payment/data/models/pending_payment_model.dart';
import 'package:apple_store/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:apple_store/features/payment/domain/repositories/payment_repository.dart';
import 'package:apple_store/features/payment/domain/usecases/start_payment.dart';
import 'package:apple_store/features/payment/domain/usecases/verify_payment.dart';
import 'package:apple_store/features/payment/presentation/bloc/payment_bloc.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  await _registerCorecomponenets();
  _registerAuthentication();
  _registerProductCategory();
  _registerHome();
  _registerProduct();
  _registerBasket();
  _registerOrders(); // جدید
  _registerPayment();
}

//Core
Future<void> _registerCorecomponenets() async {
  // Dio
  locator.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/')),
  );
  // SharedPreferences

  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
  // Hive
  // Hive
  await Hive.initFlutter();

  Hive.registerAdapter(BasketItemModelAdapter());
  Hive.registerAdapter(VariantModelAdapter());
  Hive.registerAdapter(OrderModelAdapter()); // جدید (typeId: 10)
  Hive.registerAdapter(PendingPaymentModelAdapter()); // جدید (typeId: 11)

  final basketBox = await Hive.openBox<BasketItemModel>('basket_items_box');
  final ordersBox = await Hive.openBox<OrderModel>('orders_box');
  final pendingPaymentBox = await Hive.openBox<PendingPaymentModel>(
    'pending_payments_box',
  );

  locator.registerSingleton<Box<BasketItemModel>>(basketBox);
  locator.registerSingleton<Box<OrderModel>>(ordersBox);
  locator.registerSingleton<Box<PendingPaymentModel>>(pendingPaymentBox);
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

//Product
void _registerProduct() {
  //datasources
  locator.registerFactory<ProductDatasource>(
    () => ProductRemoteDatasource(locator.get<Dio>()),
  );
  //
  locator.registerFactory<ProductGalleryDatasource>(
    () => ProductGalleryRemoteDatasource(locator.get<Dio>()),
  );
  locator.registerFactory<ProductPropertyDatasource>(
    () => ProductPropertyRemoteDatasource(locator.get<Dio>()),
  );

  //repository
  locator.registerFactory<ProductRepositiry>(
    () => ProductRepositoryImpl(locator.get<ProductDatasource>()),
  );
  locator.registerFactory<ProductGalleryRepository>(
    () => ProductGalleryRepositoryImpl(locator.get<ProductGalleryDatasource>()),
  );
  locator.registerFactory<ProductPropertyRepository>(
    () =>
        ProductPropertyRepositoryImpl(locator.get<ProductPropertyDatasource>()),
  );

  //bloc
  locator.registerFactory<ProductBloc>(
    () => ProductBloc(
      locator.get<ProductRepositiry>(),
      locator.get<ProductGalleryRepository>(),
      locator.get<ProductPropertyRepository>(),
    ),
  );

  locator.registerFactory<ProductListBloc>(
    () => ProductListBloc(locator.get<ProductRepositiry>()),
  );
}

//basket
void _registerBasket() {
  // datasource
  locator.registerLazySingleton<BasketDatasource>(
    () => BasketLocalDataSource(basketBox: locator<Box<BasketItemModel>>()),
  );

  // repository
  locator.registerLazySingleton<BasketRepository>(
    () => BasketRepositoryImpl(locator<BasketDatasource>()),
  );

  // UseCases
  locator.registerLazySingleton<AddToBasket>(
    () => AddToBasket(locator<BasketRepository>()),
  );

  locator.registerLazySingleton<GetBasket>(
    () => GetBasket(locator<BasketRepository>()),
  );

  locator.registerLazySingleton<UpdateBasketItem>(
    () => UpdateBasketItem(locator<BasketRepository>()),
  );

  locator.registerLazySingleton<RemoveFromBasket>(
    () => RemoveFromBasket(locator<BasketRepository>()),
  );

  locator.registerLazySingleton<ClearBasket>(
    () => ClearBasket(locator<BasketRepository>()),
  );

  locator.registerLazySingleton<GetSingleBasketItem>(
    () => GetSingleBasketItem(locator<BasketRepository>()),
  );

  // BasketBloc (صفحه سبد خرید) - ۵ پارامتر
  locator.registerFactory<BasketBloc>(
    () => BasketBloc(
      locator<AddToBasket>(),
      locator<GetBasket>(),
      locator<UpdateBasketItem>(),
      locator<RemoveFromBasket>(),
      locator<ClearBasket>(),
    ),
  );

  // ProductBasketBloc (دکمه سبد در صفحه محصول) - ۴ پارامتر
  locator.registerFactory<ProductBasketBloc>(
    () => ProductBasketBloc(
      locator<AddToBasket>(),
      locator<UpdateBasketItem>(),
      locator<RemoveFromBasket>(),
      locator<GetSingleBasketItem>(),
    ),
  );
}

//orders
void _registerOrders() {
  // datasource
  locator.registerLazySingleton<OrderDatasource>(
    () => OrderLocalDataSource(orderBox: locator<Box<OrderModel>>()),
  );

  // repository
  locator.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(locator<OrderDatasource>()),
  );

  // UseCases
  locator.registerLazySingleton<GetOrders>(
    () => GetOrders(locator<OrderRepository>()),
  );
  locator.registerLazySingleton<PlaceOrder>(
    () => PlaceOrder(locator<OrderRepository>(), locator<BasketRepository>()),
  );

  // bloc: هر بار که صفحه باز شود نمونه‌ی تازه
  locator.registerFactory<OrdersBloc>(() => OrdersBloc(locator<GetOrders>()));
}

//payment
void _registerPayment() {
  // تنظیمات (Sandbox/واقعی) از --dart-define
  locator.registerLazySingleton<PaymentConfig>(
    () => PaymentConfig.fromEnvironment(),
  );

  // datasources
  // برای عوض کردن درگاه، فقط همین یک ثبت عوض می‌شود
  locator.registerLazySingleton<PaymentRemoteDatasource>(
    () => ZarinpalRemoteDatasource(
      locator<PaymentConfig>(),
      Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 30),
        ),
      ),
    ),
  );
  locator.registerLazySingleton<PendingPaymentDatasource>(
    () => PendingPaymentLocalDataSource(
      pendingBox: locator<Box<PendingPaymentModel>>(),
    ),
  );

  // repository
  locator.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(
      remote: locator<PaymentRemoteDatasource>(),
      local: locator<PendingPaymentDatasource>(),
    ),
  );

  // UseCases
  locator.registerLazySingleton<StartPayment>(
    () =>
        StartPayment(locator<BasketRepository>(), locator<PaymentRepository>()),
  );
  locator.registerLazySingleton<VerifyPayment>(
    () => VerifyPayment(locator<PaymentRepository>(), locator<PlaceOrder>()),
  );

  // bloc و سرویس لینک: مالک آن‌ها MyApp است (مثل BasketBloc)
  locator.registerFactory<PaymentBloc>(
    () => PaymentBloc(locator<StartPayment>(), locator<VerifyPayment>()),
  );
  locator.registerFactory<DeepLinkService>(() => DeepLinkService());
}
