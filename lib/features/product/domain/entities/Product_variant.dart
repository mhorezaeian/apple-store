import 'package:apple_store/features/product/domain/entities/variant.dart';
import 'package:apple_store/features/product/domain/entities/variant_type.dart';

class ProductVariant {
  final VariantType? variantType;
  final List<Variant> variants;

  ProductVariant({required this.variantType, required this.variants});
}
