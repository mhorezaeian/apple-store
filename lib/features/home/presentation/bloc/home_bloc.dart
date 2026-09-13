import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/home/domain/entities/Home_banner.dart';
import 'package:apple_store/features/home/domain/repositories/banner_repository.dart';
import 'package:apple_store/features/product/domain/entities/product.dart';
import 'package:apple_store/features/product/domain/repositories/product_repositiry.dart';
import 'package:apple_store/features/product_category/domain/entities/product_category.dart';
import 'package:apple_store/features/product_category/domain/repositories/product_category_reposirory.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BannerRepository _bannerRepository;
  final ProductCategoryRepository _productCategoryRepository;
  final ProductRepositiry _productRepository;
  HomeBloc(
    this._bannerRepository,
    this._productCategoryRepository,
    this._productRepository,
  ) : super(HomeInitial()) {
    on<HomeStarted>((event, emit) async {
      await _getHomeData(emit);
    });
    on<HomeRefreshed>((event, emit) async {
      await _getHomeData(emit);
    });
  }

  Future<void> _getHomeData(Emitter<HomeState> emit) async {
    emit(HomeLoadInProgress());

    final bannerResult = await _bannerRepository.getBanners();

    final categoryResult = await _productCategoryRepository.getCategoies();

    final prodoctResult = await _productRepository.getProducts();
    final hotestProdoctResult = await _productRepository.getHotestProducts();
    final bestSellersProdoctResult = await _productRepository
        .getBestSellerProducts();

    Failure? failure;

    bannerResult.fold((f) => failure ??= f, (_) {});

    categoryResult.fold((f) => failure ??= f, (_) {});

    prodoctResult.fold((f) => failure ??= f, (_) {});
    hotestProdoctResult.fold((f) => failure ??= f, (_) {});
    bestSellersProdoctResult.fold((f) => failure ??= f, (_) {});

    if (failure != null) {
      emit(HomeLoadFailure(message: failure!.message));
      return;
    }

    emit(
      HomeLoadSuccess(
        banners: bannerResult.getOrElse(() => []),
        categories: categoryResult.getOrElse(() => []),
        hotestproducts: hotestProdoctResult.getOrElse(() => []),
        bsetSellerProducts: bestSellersProdoctResult.getOrElse(() => []),
      ),
    );
  }
}
