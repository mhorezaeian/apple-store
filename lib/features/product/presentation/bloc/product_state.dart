part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

final class ProductLoadInProgress extends ProductState {}

final class ProductLoadFailure extends ProductState {
  final String message;

  ProductLoadFailure({required this.message});
}

final class ProductLoadSuccess extends ProductState {
  final ProductDetail product;
  final List<ProductImage> productGallery;
  final List<ProductVariant> productVariants;
  final ProductCategory productCategory;

  ProductLoadSuccess({
    required this.product,
    required this.productGallery,
    required this.productVariants,
    required this.productCategory,
  });
}
