import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/product_category/domain/entities/product_category.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/product_category_reposirory.dart';
import '../datasources/product_category_datasource.dart';

class ProductCategoryReposiroryImpl implements ProductCategoryRepository {
  final ProductCategoryDatasource _datasource;

  ProductCategoryReposiroryImpl(this._datasource);

  @override
  Future<Either<Failure, List<ProductCategory>>> getCategoies() async {
    try {
      final categoriyModel = await _datasource.getCategories();

      final categories = categoriyModel
          .map((model) => model.toEntity())
          .toList();
      print(categories);

      return right(categories);
    } on NetworkException catch (e) {
      return left(
        NetworkFailure(message: 'اتصال به اینترنت یا سرور برقرار نشد'),
      );
    } on ApiException catch (e) {
      return left(ServerFailure(message: 'خطای غیرمنتظره‌ای رخ داد'));
    } on UnKnownException catch (e) {
      return left(UnknownFailure(message: e.toString()));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }
}
