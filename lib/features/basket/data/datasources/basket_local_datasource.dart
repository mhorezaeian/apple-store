import 'package:apple_store/core/error/exceptions.dart';
import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:apple_store/features/basket/data/datasources/basket_datasource.dart';
import 'package:apple_store/features/basket/data/models/basket_item_model.dart';

class BasketLocalDataSource implements BasketDatasource {
  final Box<BasketItemModel> basketBox;

  BasketLocalDataSource({required this.basketBox});

  @override
  Future<void> addToBasket(BasketItemModel item) async {
    try {
      await basketBox.put(item.id, item);
    } catch (e) {
      throw LocalStorageException(
        message: 'Failed to add basket item to local storage.',
        error: e,
      );
    }
  }

  @override
  Future<List<BasketItemModel>> getBasket() async {
    try {
      return basketBox.values.toList();
    } catch (e) {
      throw LocalStorageException(
        message: 'Failed to get basket items from local storage.',
        error: e,
      );
    }
  }

  @override
  Future<void> updateBasketItem(BasketItemModel item) async {
    try {
      await basketBox.put(item.id, item);
    } catch (e) {
      throw LocalStorageException(
        message: 'Failed to update basket item in local storage.',
        error: e,
      );
    }
  }

  @override
  Future<void> removeFromBasket(String id) async {
    try {
      await basketBox.delete(id);
    } catch (e) {
      throw LocalStorageException(
        message: 'Failed to remove basket item from local storage.',
        error: e,
      );
    }
  }

  @override
  Future<void> clearBasket() async {
    try {
      await basketBox.clear();
    } catch (e) {
      throw LocalStorageException(
        message: 'Failed to clear basket from local storage.',
        error: e,
      );
    }
  }

  @override
  Future<BasketItemModel?> getSingleBasketItem(
    String productId,
    List<String?> variantIds,
  ) async {
    try {
      final basketItems = await getBasket();

      const equality = UnorderedIterableEquality<String?>();

      for (final item in basketItems) {
        if (item.productId != productId) continue;

        final itemVariantIds = (item.variants ?? [])
            .map((variant) => variant.id)
            .toList();

        if (equality.equals(itemVariantIds, variantIds)) {
          return item;
        }
      }

      return null;
    } on LocalStorageException {
      rethrow;
    } catch (e) {
      throw LocalStorageException(
        message: 'Failed to get a single basket item from local storage.',
        error: e,
      );
    }
  }
}
