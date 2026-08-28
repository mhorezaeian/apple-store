import 'package:apple_store/features/Product_category/data/models/Product_category_model.dart';
import 'package:flutter/foundation.dart';

abstract interface class ProductCategoryDatasource {
  Future<List<ProductCategory>> getCategories();
}
