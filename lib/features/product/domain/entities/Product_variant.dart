import 'package:apple_store/features/product/data/models/variant_model.dart';
import 'package:apple_store/features/product/data/models/variant_type_model.dart';

class ProductVariant {
  final VariantTypeModel? variantType;
  final List<VariantModel> variants;

  ProductVariant({required this.variantType, required this.variants});
}
