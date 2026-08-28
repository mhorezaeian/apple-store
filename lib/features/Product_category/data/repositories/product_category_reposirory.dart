import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/core/utils/api_exception.dart';
import 'package:apple_store/features/Product_category/data/models/Product_category_model.dart';
import 'package:dartz/dartz.dart';

abstract interface class ProductCategoryRepository {
  Future<Either<Failure, List<ProductCategory>>> getCategoies();
}
