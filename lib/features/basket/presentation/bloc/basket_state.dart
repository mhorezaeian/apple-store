part of 'basket_bloc.dart';

abstract class BasketState extends Equatable {
  const BasketState();

  @override
  List<Object?> get props => [];
}

class BasketInitial extends BasketState {
  const BasketInitial();
}

class BasketLoading extends BasketState {
  const BasketLoading();
}

class BasketLoaded extends BasketState {
  final List<BasketItem> items;

  const BasketLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class BasketError extends BasketState {
  final String message;

  const BasketError(this.message);

  @override
  List<Object> get props => [message];
}

class SingleBasketItemInitial extends BasketState {
  const SingleBasketItemInitial();
}

class SingleBasketItemSuccess extends BasketState {
  final BasketItem? item;

  const SingleBasketItemSuccess(this.item);

  @override
  List<Object?> get props => [item];
}

class SingleBasketItemFailure extends BasketState {
  final String message;

  const SingleBasketItemFailure(this.message);

  @override
  List<Object?> get props => [message];
}
