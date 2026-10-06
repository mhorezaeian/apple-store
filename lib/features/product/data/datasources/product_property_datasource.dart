import 'package:apple_store/features/product/data/models/product_property_model.dart';

abstract interface class ProductPropertyDatasource {
  Future<List<ProductPropertyModel>> getProductProperty(String propertyId);
}
