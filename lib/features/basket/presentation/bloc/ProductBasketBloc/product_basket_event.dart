part of 'product_basket_bloc.dart';

abstract class ProductBasketEvent {
  const ProductBasketEvent();
}

/// درخواست وضعیت سبد برای این محصول با این واریانت‌ها
class ProductBasketRequested extends ProductBasketEvent {
  final String productId;
  final List<String?> variantIds;

  const ProductBasketRequested({
    required this.productId,
    required this.variantIds,
  });
}

/// افزودن به سبد (اولین بار)
class ProductBasketItemAdded extends ProductBasketEvent {
  final BasketItem item;
  const ProductBasketItemAdded(this.item);
}

/// تغییر تعداد (+ و -)
class ProductBasketItemUpdated extends ProductBasketEvent {
  final BasketItem item;
  const ProductBasketItemUpdated(this.item);
}

/// حذف از سبد
class ProductBasketItemRemoved extends ProductBasketEvent {
  final String id;
  const ProductBasketItemRemoved(this.id);
}
