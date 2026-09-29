import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/product/domain/entities/product_image.dart';
import 'package:dartz/dartz.dart';

abstract interface class ProductGalleryRepository {
  Future<Either<Failure, List<ProductImage>>> getProdctGallery(
    String productId,
  );
}
