import 'package:dartz/dartz.dart';

import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/basket/domain/entities/basket_item.dart';
import 'package:apple_store/features/basket/domain/repositories/basket_repository.dart';

class AddToBasket {
  final BasketRepository _repository;

  AddToBasket(this._repository);

  Future<Either<Failure, void>> call(BasketItem item) {
    return _repository.addToBasket(item);
  }
}
