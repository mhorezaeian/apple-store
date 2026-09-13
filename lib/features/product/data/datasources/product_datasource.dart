import 'package:apple_store/features/product/data/models/product_model.dart';

abstract interface class ProductDatasource {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> getHotestProducts();
  Future<List<ProductModel>> getBestSellerProducts();
}
