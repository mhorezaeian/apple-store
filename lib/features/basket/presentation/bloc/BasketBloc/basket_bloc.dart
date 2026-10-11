import 'package:apple_store/features/basket/domain/entities/basket_item.dart';
import 'package:apple_store/features/basket/domain/usecases/add_to_basket.dart';
import 'package:apple_store/features/basket/domain/usecases/clear_basket.dart';
import 'package:apple_store/features/basket/domain/usecases/get_basket.dart';
import 'package:apple_store/features/basket/domain/usecases/remove_from_basket.dart';
import 'package:apple_store/features/basket/domain/usecases/update_basket_item.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final AddToBasket _addToBasket;
  final GetBasket _getBasket;
  final UpdateBasketItem _updateBasketItem;
  final RemoveFromBasket _removeFromBasket;
  final ClearBasket _clearBasket;

  BasketBloc(
    this._addToBasket,
    this._getBasket,
    this._updateBasketItem,
    this._removeFromBasket,
    this._clearBasket,
  ) : super(const BasketInitial()) {
    on<BasketStarted>((event, emit) => _load(emit));

    on<BasketRefreshed>((event, emit) {
      return _load(emit, showLoading: state is! BasketLoaded);
    });

    on<BasketItemAdded>((event, emit) async {
      final result = await _addToBasket(event.item);
      final error = result.fold<String?>((f) => f.message, (_) => null);
      if (error != null) {
        emit(BasketError(error));
        return;
      }
      await _load(emit, showLoading: false);
    });

    on<BasketItemUpdated>((event, emit) async {
      final result = await _updateBasketItem(event.item);
      final error = result.fold<String?>((f) => f.message, (_) => null);
      if (error != null) {
        emit(BasketError(error));
        return;
      }
      await _load(emit, showLoading: false);
    });

    on<BasketItemRemoved>((event, emit) async {
      final result = await _removeFromBasket(event.id);
      final error = result.fold<String?>((f) => f.message, (_) => null);
      if (error != null) {
        emit(BasketError(error));
        return;
      }
      await _load(emit, showLoading: false);
    });

    on<BasketCleared>((event, emit) async {
      final result = await _clearBasket();
      final error = result.fold<String?>((f) => f.message, (_) => null);
      if (error != null) {
        emit(BasketError(error));
        return;
      }
      emit(const BasketLoaded([]));
    });
  }

  Future<void> _load(
    Emitter<BasketState> emit, {
    bool showLoading = true,
  }) async {
    if (showLoading) emit(const BasketLoading());

    final result = await _getBasket();
    final error = result.fold<String?>((f) => f.message, (_) => null);
    if (error != null) {
      emit(BasketError(error));
      return;
    }

    final items = result.fold<List<BasketItem>>(
      (_) => const [],
      (items) => items,
    );
    emit(BasketLoaded(items));
  }
}
