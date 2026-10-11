part of 'basket_bloc.dart';

abstract class BasketEvent extends Equatable {
  const BasketEvent();

  @override
  List<Object?> get props => [];
}

class BasketStarted extends BasketEvent {
  const BasketStarted();
}

class BasketRefreshed extends BasketEvent {
  const BasketRefreshed();
}

class BasketItemAdded extends BasketEvent {
  final BasketItem item;

  const BasketItemAdded(this.item);

  @override
  List<Object?> get props => [item];
}

class BasketItemUpdated extends BasketEvent {
  final BasketItem item;

  const BasketItemUpdated(this.item);

  @override
  List<Object?> get props => [item];
}

class BasketItemRemoved extends BasketEvent {
  final String id;

  const BasketItemRemoved(this.id);

  @override
  List<Object?> get props => [id];
}

class BasketCleared extends BasketEvent {
  const BasketCleared();
}
