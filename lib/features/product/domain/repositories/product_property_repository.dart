import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/product/domain/entities/product_property.dart';
import 'package:dartz/dartz.dart';

abstract interface class ProductPropertyRepository {
  Future<Either<Failure, List<ProductProperty>>> getProductProperty(
    String productId,
  );
}
