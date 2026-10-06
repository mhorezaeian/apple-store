part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class ProductStarted extends ProductEvent {
  final String productId;
  final String categryId;

  ProductStarted({required this.productId, required this.categryId});
}

final class ProductRefreshed extends ProductEvent {
  final String productId;
  final String categryId;

  ProductRefreshed({required this.productId, required this.categryId});
}
