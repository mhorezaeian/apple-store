import 'package:apple_store/features/basket/domain/usecases/add_to_basket.dart';
import 'package:apple_store/features/basket/domain/usecases/clear_basket.dart';
import 'package:apple_store/features/basket/domain/usecases/get_basket.dart';
import 'package:apple_store/features/basket/domain/usecases/remove_from_basket.dart';
import 'package:apple_store/features/basket/domain/usecases/update_basket_item.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:apple_store/features/basket/domain/entities/basket_item.dart';
import 'package:apple_store/features/basket/domain/usecases/get_single_basket_item.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final AddToBasket _addToBasket;
  final GetBasket _getBasket;
  final UpdateBasketItem _updateBasketItem;
  final RemoveFromBasket _removeFromBasket;
  final ClearBasket _clearBasket;
  final GetSingleBasketItem _getSingleBasketItem;
  BasketBloc(
    this._addToBasket,
    this._getBasket,
    this._updateBasketItem,
    this._removeFromBasket,
    this._clearBasket,
    this._getSingleBasketItem,
  ) : super(BasketInitial()) {
    on<BasketStarted>((event, emit) async {
      await _getBasketItems(emit);
    });

    on<BasketRefreshed>((event, emit) async {
      await _getBasketItems(emit);
    });

    on<BasketItemAdded>((event, emit) async {
      await _addBasketItem(emit, event.item);
    });

    on<BasketItemUpdated>((event, emit) async {
      await _updateBasketItemData(emit, event.item);
    });

    on<BasketItemRemoved>((event, emit) async {
      await _removeBasketItem(emit, event.id);
    });

    on<BasketCleared>((event, emit) async {
      await _clearBasketItems(emit);
    });
    on<BasketSingleItemRequested>((event, emit) async {
      await _getSingleBasketItemData(emit, event.productId, event.variantIds);
    });
  }

  Future<void> _getSingleBasketItemData(
    Emitter<BasketState> emit,
    String productId,
    List<String?> variantIds,
  ) async {
    final result = await _getSingleBasketItem(productId, variantIds);

    result.fold(
      (failure) {
        emit(SingleBasketItemFailure(failure.message));
      },
      (item) {
        emit(SingleBasketItemSuccess(item));
      },
    );
  }

  Future<void> _getBasketItems(Emitter<BasketState> emit) async {
    emit(const BasketLoading());

    final result = await _getBasket();

    result.fold(
      (failure) {
        emit(BasketError(failure.message));
      },
      (items) {
        emit(BasketLoaded(items));
      },
    );
  }

  Future<void> _addBasketItem(
    Emitter<BasketState> emit,
    BasketItem item,
  ) async {
    final result = await _addToBasket(item);

    result.fold(
      (failure) {
        emit(BasketError(failure.message));
      },
      (_) async {
        await _getBasketItems(emit);
      },
    );
  }

  Future<void> _updateBasketItemData(
    Emitter<BasketState> emit,
    BasketItem item,
  ) async {
    final result = await _updateBasketItem(item);

    result.fold(
      (failure) {
        emit(BasketError(failure.message));
      },
      (_) async {
        await _getBasketItems(emit);
      },
    );
  }

  Future<void> _removeBasketItem(Emitter<BasketState> emit, String id) async {
    final result = await _removeFromBasket(id);

    result.fold(
      (failure) {
        emit(BasketError(failure.message));
      },
      (_) async {
        await _getBasketItems(emit);
      },
    );
  }

  Future<void> _clearBasketItems(Emitter<BasketState> emit) async {
    final result = await _clearBasket();

    result.fold(
      (failure) {
        emit(BasketError(failure.message));
      },
      (_) {
        emit(const BasketLoaded([]));
      },
    );
  }
}
