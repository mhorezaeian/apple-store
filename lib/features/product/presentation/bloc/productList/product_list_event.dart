part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

final class ProductListStarted extends ProductListEvent {
  final String categryId;

  ProductListStarted({required this.categryId});
}

final class ProductListRefreshed extends ProductListEvent {
  final String categryId;

  ProductListRefreshed({required this.categryId});
}
