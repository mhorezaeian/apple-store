import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/home/presentation/widgets/category_item.dart';
import 'package:apple_store/features/product/domain/entities/Product_variant.dart';
import 'package:apple_store/features/product/domain/entities/product_detail.dart';
import 'package:apple_store/features/product/domain/entities/product_image.dart';
import 'package:apple_store/features/product/domain/entities/product_property.dart';
import 'package:apple_store/features/product/domain/repositories/product_gallery_repository.dart';
import 'package:apple_store/features/product/domain/repositories/product_property_repository.dart';
import 'package:apple_store/features/product/domain/repositories/product_repositiry.dart';
import 'package:apple_store/features/product_category/domain/entities/product_category.dart';
import 'package:apple_store/features/product_category/domain/repositories/product_category_reposirory.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepositiry _productRepositiry;
  final ProductGalleryRepository _productGalleryRepositiry;
  final ProductPropertyRepository _productPropertyRepository;
  // final ProductCategoryRepository _repository;

  ProductBloc(
    this._productRepositiry,
    this._productGalleryRepositiry,
    this._productPropertyRepository,
  ) : super(ProductInitial()) {
    on<ProductStarted>((event, emit) async {
      await _getProductDetail(emit, event.productId, event.categryId);
      // TODO: implement event handler
    });
    on<ProductRefreshed>((event, emit) async {
      await _getProductDetail(emit, event.productId, event.categryId);
      // TODO: implement event handler
    });
  }

  Future<void> _getProductDetail(
    Emitter<ProductState> emit,
    String productId,
    String categoryId,
  ) async {
    emit(ProductLoadInProgress());

    final productDetailResult = await _productRepositiry.getProduct(productId);

    final productGalleryResult = await _productGalleryRepositiry
        .getProdctGallery(productId);
    final productVariantsResult = await _productRepositiry.getProductVarients(
      productId,
    );
    final productCategoryResult = await _productRepositiry.getProductCategory(
      categoryId,
    );
    final productPropertiesResult = await _productPropertyRepository
        .getProductProperty(productId);

    Failure? failure;

    productDetailResult.fold((f) => failure ??= f, (_) {});
    productGalleryResult.fold((f) => failure ??= f, (_) {});
    productVariantsResult.fold((f) => failure ??= f, (_) {});
    productCategoryResult.fold((f) => failure ??= f, (_) {});
    productPropertiesResult.fold((f) => failure ??= f, (_) {});

    if (failure != null) {
      emit(ProductLoadFailure(message: failure!.message));
      return;
    }
    emit(
      ProductLoadSuccess(
        product: productDetailResult.getOrElse(() => ProductDetail()),
        productGallery: productGalleryResult.getOrElse(() => []),
        productVariants: productVariantsResult.getOrElse(() => []),
        productCategory: productCategoryResult.getOrElse(
          () => ProductCategory(),
        ),
        productProprtiers: productPropertiesResult.getOrElse(() => []),
      ),
    );
  }
}
