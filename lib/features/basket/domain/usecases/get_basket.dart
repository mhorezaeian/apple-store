import 'package:dartz/dartz.dart';

import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/basket/domain/entities/basket_item.dart';
import 'package:apple_store/features/basket/domain/repositories/basket_repository.dart';

class GetBasket {
  final BasketRepository _repository;

  GetBasket(this._repository);

  Future<Either<Failure, List<BasketItem>>> call() {
    return _repository.getBasket();
  }
}
