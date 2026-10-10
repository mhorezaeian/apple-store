import 'package:apple_store/features/basket/data/models/basket_item_model.dart';

abstract interface class BasketDatasource {
  Future<void> addToBasket(BasketItemModel item);

  Future<List<BasketItemModel>> getBasket();

  Future<void> updateBasketItem(BasketItemModel item);

  Future<void> removeFromBasket(String id);

  Future<void> clearBasket();

  Future<BasketItemModel?> getSingleBasketItem(
    String productId,
    List<String?> variantIds,
  );
}
