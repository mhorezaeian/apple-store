part of 'product_basket_bloc.dart';

abstract class ProductBasketState {
  const ProductBasketState();
}

class ProductBasketInitial extends ProductBasketState {
  const ProductBasketInitial();
}

/// item == null یعنی این ترکیب در سبد نیست
class ProductBasketSuccess extends ProductBasketState {
  final BasketItem? item;
  const ProductBasketSuccess(this.item);
}

class ProductBasketFailure extends ProductBasketState {
  final String message;
  const ProductBasketFailure(this.message);
}
