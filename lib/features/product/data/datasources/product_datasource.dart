import 'package:apple_store/features/product/data/models/product_model.dart';
import 'package:apple_store/features/product/data/models/variant_model.dart';
import 'package:apple_store/features/product/data/models/variant_type_model.dart';
import 'package:apple_store/features/product_category/data/models/product_category_model.dart';

abstract interface class ProductDatasource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProduct(String productId);
  Future<List<ProductModel>> getHotestProducts();
  Future<List<ProductModel>> getBestSellerProducts();
  Future<VariantTypeModel> getVariantType(String variantTypeId);
  Future<List<VariantModel>> getVariants(String productId);
  Future<ProductCategoryModel> getProductCategory(String productCategoryId);
}
