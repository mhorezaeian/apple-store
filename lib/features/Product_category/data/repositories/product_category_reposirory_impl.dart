import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/Product_category/data/datasources/Product_category_datasource.dart';
import 'package:apple_store/features/Product_category/data/models/Product_category_model.dart';
import 'package:apple_store/features/Product_category/data/repositories/product_category_reposirory.dart';
import 'package:dartz/dartz.dart';

class ProductCategoryReposiroryImpl implements ProductCategoryRepository {
  final ProductCategoryDatasource _datasource;

  ProductCategoryReposiroryImpl(this._datasource);

  @override
  Future<Either<Failure, List<ProductCategory>>> getCategoies() async {
    try {
      final categories = await _datasource.getCategories();

      return right(categories);
    } on NetworkException catch (e) {
      return left(
        NetworkFailure(message: 'اتصال به اینترنت یا سرور برقرار نشد.'),
      );
    } on ApiException catch (e) {
      return left(ServerFailure(message: 'خطای غیرمنتظره‌ای رخ داد.'));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }
}
