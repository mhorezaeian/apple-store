import 'package:dartz/dartz.dart';
import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/basket/domain/entities/basket_item.dart';
import 'package:apple_store/features/basket/domain/repositories/basket_repository.dart';

class GetSingleBasketItem {
  final BasketRepository _repository;

  GetSingleBasketItem(this._repository);

  Future<Either<Failure, BasketItem?>> call(
    String productId,
    List<String?> variantIds,
  ) {
    return _repository.getSingleBasketItem(productId, variantIds);
  }
}
