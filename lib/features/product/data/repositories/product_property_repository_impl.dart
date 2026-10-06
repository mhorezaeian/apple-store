import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/product/data/datasources/product_property_datasource.dart';
import 'package:apple_store/features/product/domain/entities/product_property.dart';
import 'package:apple_store/features/product/domain/repositories/product_property_repository.dart';
import 'package:dartz/dartz.dart';

class ProductPropertyRepositoryImpl implements ProductPropertyRepository {
  final ProductPropertyDatasource _datasource;

  ProductPropertyRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<ProductProperty>>> getProductProperty(
    String productId,
  ) async {
    try {
      print(
        "_______________________product property repository list_________________________",
      );
      final prodctProperties = await _datasource.getProductProperty(productId);

      print(prodctProperties.toString());
      final pProduct = prodctProperties
          .map((model) => model.toEntity())
          .toList();

      print(pProduct.toString());
      print(pProduct.toString());
      return right(pProduct);
    } on NetworkException catch (e) {
      return left(NetworkFailure());
    } on ServerException catch (e) {
      return left(ServerFailure());
    } on UnKnownException catch (e) {
      return left(UnknownFailure(message: e.message.toString()));
    } catch (e) {
      return left(UnknownFailure(message: ' ${e.toString()}fucking property'));
    }
  }
}
