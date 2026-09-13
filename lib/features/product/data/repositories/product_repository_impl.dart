import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/product/data/datasources/product_datasource.dart';
import 'package:apple_store/features/product/domain/entities/product.dart';
import 'package:apple_store/features/product/domain/repositories/product_repositiry.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl implements ProductRepositiry {
  final ProductDatasource _datasource;

  ProductRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final productModels = await _datasource.getProducts();

      final products = productModels.map((model) => model.toEntity()).toList();
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

      final products = productModels.map((model) => model.toEntity()).toList();
      return right(products);
    } on NetworkException catch (e) {
      return left(NetworkFailure());
    } on ServerException catch (e) {
      print('on best seller product');

      print(e.toString());

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

      final products = productModels.map((model) => model.toEntity()).toList();
      return right(products);
    } on NetworkException catch (e) {
      return left(NetworkFailure());
    } on ServerException catch (e) {
      print('on hotest product');
      print(e.toString());
      return left(ServerFailure());
    } on UnKnownException catch (e) {
      return left(UnknownFailure(message: e.message.toString()));
    } catch (e) {
      return left(UnknownFailure(message: ' ${e.toString()}fucking products'));
    }
  }
}
