import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/product/domain/entities/Product_variant.dart';
import 'package:apple_store/features/product/domain/entities/product.dart';
import 'package:apple_store/features/product/domain/entities/product_detail.dart';
import 'package:apple_store/features/product_category/domain/entities/product_category.dart';
import 'package:dartz/dartz.dart';

abstract interface class ProductRepositiry {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, ProductDetail>> getProduct(String id);
  Future<Either<Failure, ProductCategory>> getProductCategory(
    String CategoryId,
  );
  Future<Either<Failure, List<Product>>> getHotestProducts();
  Future<Either<Failure, List<Product>>> getBestSellerProducts();
  Future<Either<Failure, List<ProductVariant>>> getProductVarients(
    String productId,
  );
  Future<Either<Failure, List<Product>>> getProductsByCategory(
    String caregoryId,
  );
}
