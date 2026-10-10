import 'package:apple_store/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:collection/collection.dart';

import 'package:apple_store/core/error/failures.dart';

import 'package:apple_store/features/basket/data/datasources/basket_datasource.dart';
import 'package:apple_store/features/basket/data/models/basket_item_model.dart';

import 'package:apple_store/features/basket/domain/entities/basket_item.dart';
import 'package:apple_store/features/basket/domain/repositories/basket_repository.dart';

// class BasketRepositoryImpl implements BasketRepository {
//   final BasketDatasource _datasource;

//   BasketRepositoryImpl(this._datasource);

//   @override
//   Future<Either<Failure, void>> addToBasket(BasketItem item) async {
//     try {
//       final basketItems = await _datasource.getBasket();

//       final existingIndex = basketItems.indexWhere(
//         (existingItem) => _isSameBasketItem(existingItem.toEntity(), item),
//       );

//       if (existingIndex != -1) {
//         final existingItem = basketItems[existingIndex];

//         final updatedItem = BasketItemModel(
//           id: existingItem.id,
//           productId: existingItem.productId,
//           name: existingItem.name,
//           price: existingItem.price,
//           discountPrice: existingItem.discountPrice,
//           thumbnail: existingItem.thumbnail,
//           quantity: (existingItem.quantity ?? 0) + (item.quantity ?? 1),
//           variants: existingItem.variants,
//         );

//         await _datasource.updateBasketItem(updatedItem);
//       } else {
//         final newItem = BasketItemModel.fromEntity(item);

//         await _datasource.addToBasket(newItem);
//       }

//       return right(null);
//     } on LocalStorageException catch (e) {
//       return left(LocalStorageFailure(message: e.message));
//     } catch (e) {
//       return left(const UnknownFailure());
//     }
//   }

//   // bool _isSameBasketItem(BasketItem first, BasketItem second) {
//   //   if (first.productId != second.productId) {
//   //     return false;
//   //   }

//   //   final firstVariants = first.variants ?? [];
//   //   final secondVariants = second.variants ?? [];

//   //   if (firstVariants.length != secondVariants.length) {
//   //     return false;
//   //   }

//   //   for (final firstVariant in firstVariants) {
//   //     final exists = secondVariants.any(
//   //       (secondVariant) =>
//   //           secondVariant.id == firstVariant.id &&
//   //           secondVariant.value == firstVariant.value,
//   //     );

//   //     if (!exists) {
//   //       return false;
//   //     }
//   //   }

//   //   return true;
//   // }
//   bool _isSameBasketItem(BasketItem first, BasketItem second) {
//     // محصول متفاوت است
//     if (first.productId != second.productId) {
//       return false;
//     }

//     final firstVariants = first.variants ?? [];
//     final secondVariants = second.variants ?? [];

//     // تعداد Variantها متفاوت است
//     if (firstVariants.length != secondVariants.length) {
//       return false;
//     }

//     // ترتیب Variantها مهم نیست
//     for (final firstVariant in firstVariants) {
//       final exists = secondVariants.any(
//         (secondVariant) => secondVariant.id == firstVariant.id,
//       );

//       if (!exists) {
//         return false;
//       }
//     }

//     return true;
//   }

//   @override
//   Future<Either<Failure, List<BasketItem>>> getBasket() async {
//     try {
//       final basketItemModels = await _datasource.getBasket();

//       final basketItems = basketItemModels
//           .map((item) => item.toEntity())
//           .toList();

//       return right(basketItems);
//     } on LocalStorageException catch (e) {
//       return left(LocalStorageFailure(message: e.message));
//     } catch (e) {
//       return left(const UnknownFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, void>> updateBasketItem(BasketItem item) async {
//     try {
//       final basketItemModel = BasketItemModel.fromEntity(item);

//       await _datasource.updateBasketItem(basketItemModel);

//       return right(null);
//     } on LocalStorageException catch (e) {
//       return left(LocalStorageFailure(message: e.message));
//     } catch (e) {
//       return left(const UnknownFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, void>> removeFromBasket(String id) async {
//     try {
//       await _datasource.removeFromBasket(id);

//       return right(null);
//     } on LocalStorageException catch (e) {
//       return left(LocalStorageFailure(message: e.message));
//     } catch (e) {
//       return left(const UnknownFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, void>> clearBasket() async {
//     try {
//       await _datasource.clearBasket();

//       return right(null);
//     } on LocalStorageException catch (e) {
//       return left(LocalStorageFailure(message: e.message));
//     } catch (e) {
//       return left(const UnknownFailure());
//     }
//   }
// }

class BasketRepositoryImpl implements BasketRepository {
  final BasketDatasource _datasource;

  BasketRepositoryImpl(this._datasource);

  final UnorderedIterableEquality<String?> _variantEquality =
      const UnorderedIterableEquality<String?>();

  @override
  Future<Either<Failure, void>> addToBasket(BasketItem item) async {
    try {
      final basketItems = await _datasource.getBasket();

      final existingIndex = basketItems.indexWhere(
        (existingItem) => _isSameBasketItem(existingItem.toEntity(), item),
      );

      if (existingIndex != -1) {
        final existingItem = basketItems[existingIndex];

        final updatedItem = BasketItemModel(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          price: existingItem.price,
          discountPrice: existingItem.discountPrice,
          thumbnail: existingItem.thumbnail,
          quantity: (existingItem.quantity ?? 0) + (item.quantity ?? 1),
          variants: existingItem.variants,
        );

        await _datasource.updateBasketItem(updatedItem);
      } else {
        final newItem = BasketItemModel.fromEntity(item);

        await _datasource.addToBasket(newItem);
      }

      return right(null);
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.message));
    } catch (e) {
      return left(const UnknownFailure());
    }
  }

  bool _isSameBasketItem(BasketItem first, BasketItem second) {
    // 1. Product باید یکی باشد
    if (first.productId != second.productId) {
      return false;
    }

    // 2. Variant ها را به ID تبدیل می‌کنیم
    final firstVariantIds = (first.variants ?? [])
        .map((variant) => variant.id)
        .toList();

    final secondVariantIds = (second.variants ?? [])
        .map((variant) => variant.id)
        .toList();

    // 3. تعداد Variant ها باید یکی باشد
    if (firstVariantIds.length != secondVariantIds.length) {
      return false;
    }

    // 4. ترتیب Variant ها مهم نیست
    return _variantEquality.equals(firstVariantIds, secondVariantIds);
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

  @override
  Future<Either<Failure, BasketItem?>> getSingleBasketItem(
    String productId,
    List<String?> variantIds,
  ) async {
    try {
      final item = await _datasource.getSingleBasketItem(productId, variantIds);

      return right(item?.toEntity());
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.message));
    } catch (e) {
      return left(const UnknownFailure());
    }
  }
}
