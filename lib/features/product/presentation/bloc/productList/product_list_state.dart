part of 'product_list_bloc.dart';

abstract class ProductlistState extends Equatable {
  const ProductlistState();

  @override
  List<Object> get props => [];
}

class ProductListInitial extends ProductlistState {}

final class ProductLoadInProgress extends ProductlistState {}

final class ProductListLoadFailure extends ProductlistState {
  final String message;

  ProductListLoadFailure({required this.message});
}

final class ProductListLoadSuccess extends ProductlistState {
  final List<Product> products;

  ProductListLoadSuccess({required this.products});
}
