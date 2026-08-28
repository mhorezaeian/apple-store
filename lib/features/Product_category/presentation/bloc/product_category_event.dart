import 'package:equatable/equatable.dart';

sealed class ProductCategoryEvent extends Equatable {
  const ProductCategoryEvent();

  @override
  List<Object> get props => [];
}

final class ProductCategoryStarted extends ProductCategoryEvent {}

final class ProductCategoryRefreshed extends ProductCategoryEvent {}
