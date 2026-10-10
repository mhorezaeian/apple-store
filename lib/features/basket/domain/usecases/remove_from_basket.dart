import 'package:dartz/dartz.dart';

import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/basket/domain/repositories/basket_repository.dart';

class RemoveFromBasket {
  final BasketRepository _repository;

  RemoveFromBasket(this._repository);

  Future<Either<Failure, void>> call(String id) {
    return _repository.removeFromBasket(id);
  }
}
