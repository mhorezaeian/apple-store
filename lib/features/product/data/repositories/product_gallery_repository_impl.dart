import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/product/data/datasources/product_gallery_datasource.dart';
import 'package:apple_store/features/product/data/models/product_image_model.dart';
import 'package:apple_store/features/product/domain/entities/product_image.dart';
import 'package:apple_store/features/product/domain/repositories/product_gallery_repository.dart';
import 'package:dartz/dartz.dart';

class ProductGalleryRepositoryImpl implements ProductGalleryRepository {
  final ProductGalleryDatasource _datasource;

  ProductGalleryRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<ProductImage>>> getProdctGallery(
    String productId,
  ) async {
    try {
      final ProductImages = await _datasource.getProductGallery(productId);
      // print(ProductImages);

      final ProductGallery = ProductImages.map(
        (model) => model.toProductImageEntity(),
      ).toList();
      // print(ProductGallery);
      return right(ProductGallery);
    } on NetworkException catch (e) {
      return left(NetworkFailure());
    } on ServerException catch (e) {
      return left(ServerFailure());
    } on UnKnownException catch (e) {
      return left(UnknownFailure(message: e.message.toString()));
    } catch (e) {
      return left(UnknownFailure(message: ' ${e.toString()}fucking images'));
    }
  }
}
