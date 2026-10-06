import 'package:apple_store/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';

import 'package:apple_store/core/error/failures.dart';

import 'package:apple_store/features/basket/data/datasources/basket_datasource.dart';
import 'package:apple_store/features/basket/data/models/basket_item_model.dart';

import 'package:apple_store/features/basket/domain/entities/basket_item.dart';
import 'package:apple_store/features/basket/domain/repositories/basket_repository.dart';

class BasketRepositoryImpl implements BasketRepository {
  final BasketDatasource _datasource;

  BasketRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, void>> addToBasket(BasketItem item) async {
    try {
      final basketItemModel = BasketItemModel.fromEntity(item);

      await _datasource.addToBasket(basketItemModel);

      return right(null);
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.message));
    } catch (e) {
      return left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<BasketItem>>> getBasket() async {
    try {
      final basketItemModels = await _datasource.getBasket();

      final basketItems = basketItemModels
          .map((item) => item.toEntity())
          .toList();

      return right(basketItems);
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.message));
    } catch (e) {
      return left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateBasketItem(BasketItem item) async {
    try {
      final basketItemModel = BasketItemModel.fromEntity(item);

      await _datasource.updateBasketItem(basketItemModel);

      return right(null);
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.message));
    } catch (e) {
      return left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFromBasket(String id) async {
    try {
      await _datasource.removeFromBasket(id);

      return right(null);
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.message));
    } catch (e) {
      return left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> clearBasket() async {
    try {
      await _datasource.clearBasket();

      return right(null);
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.message));
    } catch (e) {
      return left(const UnknownFailure());
    }
  }
}
