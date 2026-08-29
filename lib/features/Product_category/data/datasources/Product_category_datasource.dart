import 'package:apple_store/features/product_category/data/models/product_category_model.dart';

abstract interface class ProductCategoryDatasource {
  Future<List<ProductCategoryModel>> getCategories();
}
