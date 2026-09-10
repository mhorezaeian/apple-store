part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class ProductStarted extends ProductEvent {}

final class ProductRefreshed extends ProductEvent {}
