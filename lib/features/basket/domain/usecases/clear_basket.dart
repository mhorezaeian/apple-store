import 'package:dartz/dartz.dart';

import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/basket/domain/repositories/basket_repository.dart';

class ClearBasket {
  final BasketRepository _repository;

  ClearBasket(this._repository);

  Future<Either<Failure, void>> call() {
    return _repository.clearBasket();
  }
}
