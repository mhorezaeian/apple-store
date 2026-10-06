import 'package:dartz/dartz.dart';

import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/basket/domain/entities/basket_item.dart';

abstract class BasketRepository {
  Future<Either<Failure, void>> addToBasket(BasketItem item);

  Future<Either<Failure, List<BasketItem>>> getBasket();

  Future<Either<Failure, void>> updateBasketItem(BasketItem item);

  Future<Either<Failure, void>> removeFromBasket(String id);

  Future<Either<Failure, void>> clearBasket();
}
