import 'package:apple_store/features/orders/domain/entities/order.dart';
import 'package:apple_store/features/orders/domain/usecases/get_orders.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'orders_event.dart';
part 'orders_state.dart';

/// فقط وضعیت صفحه «سابقه خرید» را مدیریت می‌کند؛ منطق در UseCase است.
class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrders _getOrders;

  OrdersBloc(this._getOrders) : super(const OrdersInitial()) {
    on<OrdersStarted>((event, emit) => _load(emit));
    on<OrdersRefreshed>((event, emit) => _load(emit));
  }

  Future<void> _load(Emitter<OrdersState> emit) async {
    emit(const OrdersLoading());

    final result = await _getOrders();
    result.fold(
      (failure) => emit(OrdersError(failure.message)),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }
}
