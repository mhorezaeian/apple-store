import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/product/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

abstract interface class ProductRepositiry {
  Future<Either<Failure, List<Product>>> getProducts();
}
