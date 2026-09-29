import 'package:apple_store/features/product/data/models/product_image_model.dart';
import 'package:apple_store/features/product_category/data/models/product_category_model.dart';

abstract interface class ProductGalleryDatasource {
  Future<List<ProductImageModel>> getProductGallery(String ProductId);
}
