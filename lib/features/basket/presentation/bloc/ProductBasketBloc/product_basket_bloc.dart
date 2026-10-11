import 'package:bloc/bloc.dart';

import 'package:apple_store/features/basket/domain/entities/basket_item.dart';
import 'package:apple_store/features/basket/domain/usecases/add_to_basket.dart';
import 'package:apple_store/features/basket/domain/usecases/get_single_basket_item.dart';
import 'package:apple_store/features/basket/domain/usecases/remove_from_basket.dart';
import 'package:apple_store/features/basket/domain/usecases/update_basket_item.dart';

part 'product_basket_event.dart';
part 'product_basket_state.dart';

class ProductBasketBloc extends Bloc<ProductBasketEvent, ProductBasketState> {
  final AddToBasket _addToBasket;
  final UpdateBasketItem _updateBasketItem;
  final RemoveFromBasket _removeFromBasket;
  final GetSingleBasketItem _getSingleBasketItem;

  String? _productId;
  List<String?>? _variantIds;

  ProductBasketBloc(
    this._addToBasket,
    this._updateBasketItem,
    this._removeFromBasket,
    this._getSingleBasketItem,
  ) : super(const ProductBasketInitial()) {
    on<ProductBasketRequested>((event, emit) async {
      _productId = event.productId;
      _variantIds = List<String?>.from(event.variantIds);
      await _refresh(emit);
    });

    on<ProductBasketItemAdded>((event, emit) async {
      final result = await _addToBasket(event.item);
      final error = result.fold<String?>((f) => f.message, (_) => null);
      if (error != null) {
        emit(ProductBasketFailure(error));
        return;
      }
      await _refresh(emit);
    });

    on<ProductBasketItemUpdated>((event, emit) async {
      final result = await _updateBasketItem(event.item);
      final error = result.fold<String?>((f) => f.message, (_) => null);
      if (error != null) {
        emit(ProductBasketFailure(error));
        return;
      }
      await _refresh(emit);
    });

    on<ProductBasketItemRemoved>((event, emit) async {
      final result = await _removeFromBasket(event.id);
      final error = result.fold<String?>((f) => f.message, (_) => null);
      if (error != null) {
        emit(ProductBasketFailure(error));
        return;
      }
      await _refresh(emit);
    });
  }

  Future<void> _refresh(Emitter<ProductBasketState> emit) async {
    final productId = _productId;
    final variantIds = _variantIds;
    if (productId == null || variantIds == null) return;

    final result = await _getSingleBasketItem(productId, variantIds);
    final error = result.fold<String?>((f) => f.message, (_) => null);
    if (error != null) {
      emit(ProductBasketFailure(error));
      return;
    }

    final item = result.fold<BasketItem?>((_) => null, (item) => item);
    emit(ProductBasketSuccess(item));
  }
}
