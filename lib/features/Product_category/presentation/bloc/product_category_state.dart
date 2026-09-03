import 'package:apple_store/features/product_category/domain/entities/product_category.dart';
import 'package:equatable/equatable.dart';

sealed class ProductCategoryState extends Equatable {
  const ProductCategoryState();

  @override
  List<Object> get props => [];
}

final class ProductCategoryInitial extends ProductCategoryState {}

final class ProductCategoryLoadInProgress extends ProductCategoryState {}

final class ProductCategoryLoadFailure extends ProductCategoryState {
  final String message;
  const ProductCategoryLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class ProductCategoryLoadSuccess extends ProductCategoryState {
  final List<ProductCategory> categories;
  const ProductCategoryLoadSuccess({required this.categories});
  @override
  List<Object> get props => [categories];
}

// class ProductCategorySuccess extends ProductCategoryState {S
//   Either<ApiException, List<ProductCategory>> responce;
//   ProductCategorySuccess({required this.responce});
// }
