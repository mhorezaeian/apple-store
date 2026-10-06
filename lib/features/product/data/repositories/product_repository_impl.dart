import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/product/data/datasources/product_datasource.dart';
import 'package:apple_store/features/product/data/models/variant_type_model.dart';
import 'package:apple_store/features/product/domain/entities/Product_variant.dart';
import 'package:apple_store/features/product/domain/entities/product.dart';
import 'package:apple_store/features/product/domain/entities/product_detail.dart';
import 'package:apple_store/features/product/domain/repositories/product_repositiry.dart';
import 'package:apple_store/features/product_category/domain/entities/product_category.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class ProductRepositoryImpl implements ProductRepositiry {
  final ProductDatasource _datasource;

  ProductRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final productModels = await _datasource.getAllProducts();

      final products = productModels
          .map((model) => model.toProductEntity())
          .toList();
      return right(products);
    } on NetworkException catch (e) {
      return left(NetworkFailure());
    } on ServerException catch (e) {
      return left(ServerFailure());
    } on UnKnownException catch (e) {
      return left(UnknownFailure(message: e.message.toString()));
    } catch (e) {
      return left(UnknownFailure(message: ' ${e.toString()}fucking products'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getBestSellerProducts() async {
    try {
      final productModels = await _datasource.getBestSellerProducts();

      final products = productModels
          .map((model) => model.toProductEntity())
          .toList();
      return right(products);
    } on NetworkException catch (e) {
      return left(NetworkFailure());
    } on ServerException catch (e) {
      ;

      return left(ServerFailure());
    } on UnKnownException catch (e) {
      return left(UnknownFailure(message: e.message.toString()));
    } catch (e) {
      return left(UnknownFailure(message: ' ${e.toString()}fucking products'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getHotestProducts() async {
    try {
      final productModels = await _datasource.getHotestProducts();

      final products = productModels
          .map((model) => model.toProductEntity())
          .toList();
      return right(products);
    } on NetworkException catch (e) {
      return left(NetworkFailure());
    } on ServerException catch (e) {
      return left(ServerFailure());
    } on UnKnownException catch (e) {
      return left(UnknownFailure(message: e.message.toString()));
    } catch (e) {
      return left(UnknownFailure(message: ' ${e.toString()}fucking products'));
    }
  }

  @override
  Future<Either<Failure, ProductDetail>> getProduct(String id) async {
    try {
      final productModel = await _datasource.getProduct(id);

      final product = productModel.toProductDetailEntity();
      return right(product);
    } on NetworkException catch (e) {
      return left(NetworkFailure());
    } on ServerException catch (e) {
      return left(ServerFailure());
    } on UnKnownException catch (e) {
      return left(UnknownFailure(message: e.message.toString()));
    } catch (e) {
      return left(
        UnknownFailure(message: ' ${e.toString()} in  detail product'),
      );
    }
  }

  // @override
  // Future<Either<Failure, List<ProductVariant>>> getProductVarients(
  //   String productId,
  // ) async {
  //   try {
  //     final Map<String, VariantTypeModel> variantTypes = {};

  //     // دریافت تمام variant ها
  //     final variants = await _datasource.getVariants(productId);

  //     // دریافت type مربوط به هر variant
  //     for (final variant in variants) {
  //       final typeId = variant.type_id;

  //       if (typeId == null) {
  //         continue;
  //       }

  //       if (!variantTypes.containsKey(typeId)) {
  //         final type = await _datasource.getVariantType(typeId);
  //         variantTypes[typeId] = type;
  //       }
  //     }

  //     // گروه‌بندی variant ها بر اساس type_id
  //     final Map<String, ProductVariant> productVariants = {};

  //     for (final variant in variants) {
  //       final typeId = variant.type_id;

  //       if (typeId == null) {
  //         continue;
  //       }

  //       final productVariant = productVariants.putIfAbsent(
  //         typeId,
  //         () =>
  //             ProductVariant(variantType: variantTypes[typeId]!, variants: []),
  //       );

  //       productVariant.variants.add(variant);
  //     }

  //     final result = productVariants.values.toList();

  //     return Right(result);
  //   } on NetworkException {
  //     return left(NetworkFailure());
  //   } on ServerException catch (e) {
  //     return left(ServerFailure());
  //   } on UnKnownException catch (e) {
  //     return left(UnknownFailure(message: e.message.toString()));
  //   } catch (e) {
  //     return left(
  //       UnknownFailure(message: '${e.toString()} in product variants!!'),
  //     );
  //   }
  // }
  @override
  Future<Either<Failure, List<ProductVariant>>> getProductVarients(
    String productId,
  ) async {
    try {
      final Map<String, VariantTypeModel> variantTypes = {};

      // دریافت تمام Variant های محصول از DataSource
      final variants = await _datasource.getVariants(productId);

      // دریافت VariantType مربوط به هر Variant
      for (final variant in variants) {
        final typeId = variant.type_id;

        if (typeId == null) {
          continue;
        }

        if (!variantTypes.containsKey(typeId)) {
          final type = await _datasource.getVariantType(typeId);

          variantTypes[typeId] = type;
        }
      }

      // گروه‌بندی Variant ها بر اساس type_id
      final Map<String, ProductVariant> productVariants = {};

      for (final variantModel in variants) {
        final typeId = variantModel.type_id;

        if (typeId == null) {
          continue;
        }

        final productVariant = productVariants.putIfAbsent(
          typeId,
          () => ProductVariant(
            variantType: variantTypes[typeId]!.toEntity(),
            variants: [],
          ),
        );

        productVariant.variants.add(variantModel.toEntity());
      }

      final result = productVariants.values.toList();

      return Right(result);
    } on NetworkException {
      return left(NetworkFailure());
    } on ServerException {
      return left(ServerFailure());
    } on UnKnownException catch (e) {
      return left(UnknownFailure(message: e.message.toString()));
    } catch (e) {
      return left(
        UnknownFailure(message: '${e.toString()} in product variants!!'),
      );
    }
  }

  @override
  Future<Either<Failure, ProductCategory>> getProductCategory(
    String categoryId,
  ) async {
    try {
      final productCategory = await _datasource.getProductCategory(categoryId);

      final category = productCategory.toEntity();
      return right(category);
    } on NetworkException catch (e) {
      return left(NetworkFailure());
    } on ServerException catch (e) {
      return left(ServerFailure());
    } on UnKnownException catch (e) {
      return left(UnknownFailure(message: e.message.toString()));
    } catch (e) {
      return left(
        UnknownFailure(message: ' ${e.toString()} in  detail product'),
      );
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
    String caregoryId,
  ) async {
    try {
      final productModels = await _datasource.getProductsByCategory(caregoryId);

      final products = productModels
          .map((model) => model.toProductEntity())
          .toList();

      print(products);
      return right(products);
    } on NetworkException catch (e) {
      return left(NetworkFailure());
    } on ServerException catch (e) {
      return left(ServerFailure());
    } on UnKnownException catch (e) {
      return left(UnknownFailure(message: e.message.toString()));
    } catch (e) {
      return left(UnknownFailure(message: ' ${e.toString()}fucking products'));
    }
  }
}
