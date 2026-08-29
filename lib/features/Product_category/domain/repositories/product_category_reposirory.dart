import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/product_category/domain/entities/product_category.dart';
import 'package:dartz/dartz.dart';

abstract interface class ProductCategoryRepository {
  Future<Either<Failure, List<ProductCategory>>> getCategoies();
}
