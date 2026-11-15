part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

/// صفحه باز شد
class OrdersStarted extends OrdersEvent {
  const OrdersStarted();
}

/// تلاش دوباره بعد از خطا
class OrdersRefreshed extends OrdersEvent {
  const OrdersRefreshed();
}
