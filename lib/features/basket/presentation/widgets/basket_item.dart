import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/core/utils/price_formatter.dart';
import 'package:apple_store/core/widgets/cached_image.dart';
import 'package:apple_store/features/basket/domain/entities/basket_item.dart'
    as domain;
import 'package:apple_store/features/product/domain/entities/variant.dart';
import 'package:flutter/material.dart';

class BasketItem extends StatelessWidget {
  final domain.BasketItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const BasketItem({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final basePrice = item.price ?? 0;
    final discountAmount = item.discountPrice ?? 0;
    final listUnitPrice = PriceFormatter.unitListPrice(
      basePrice: item.price,
      variants: item.variants,
    );
    final lineTotal = PriceFormatter.lineTotal(item);
    final quantity = item.quantity ?? 1;
    final variants = item.variants ?? const <Variant>[];

    return Padding(
      padding: const EdgeInsets.only(left: 44.0, right: 44, bottom: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              item.name ?? '',
                              style: const TextStyle(
                                fontFamily: 'sb',
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (discountAmount > 0)
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.red,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 1,
                                      horizontal: 6,
                                    ),
                                    child: Text(
                                      '${PriceFormatter.discountPercent(basePrice, discountAmount)}%',
                                      style: const TextStyle(
                                        fontFamily: 'sm',
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              if (discountAmount > 0) const SizedBox(width: 3),
                              const Text(
                                'تومان',
                                style: TextStyle(
                                  fontFamily: 'sm',
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                PriceFormatter.format(listUnitPrice),
                                style: TextStyle(
                                  decoration: discountAmount > 0
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  decorationColor: Colors.grey,
                                  decorationThickness: 3,
                                  fontFamily: 'sm',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          if (variants.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Wrap(
                              alignment: WrapAlignment.end,
                              spacing: 8,
                              runSpacing: 6,
                              children: variants.map(_variantChip).toList(),
                            ),
                          ],
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: onRemove,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      width: 1,
                                      color: Mycolor.gery,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.0,
                                          ),
                                          child: Text(
                                            'حذف',
                                            style: TextStyle(
                                              fontFamily: 'sm',
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/icon_trash.png',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      width: 1,
                                      color: Mycolor.gery,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                      vertical: 2,
                                    ),
                                    child: Row(
                                      children: [
                                        _smallIconButton(
                                          icon: Icons.remove,
                                          onTap: onDecrement,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Text(
                                            '$quantity',
                                            style: const TextStyle(
                                              fontFamily: 'sm',
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        _smallIconButton(
                                          icon: Icons.add,
                                          onTap: onIncrement,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: _buildThumbnail(),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 0.8, indent: 2, endIndent: 2),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'تومان',
                      style: TextStyle(fontFamily: 'sb', fontSize: 16),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      PriceFormatter.format(lineTotal),
                      style: const TextStyle(fontFamily: 'sb', fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    final url = item.thumbnail;
    if (url != null && url.isNotEmpty) {
      return CachedImage(imageUrl: url, width: 72, height: 72, radius: 8);
    }
    return Image.asset('assets/images/iphone.png', width: 72, height: 72);
  }

  Widget _variantChip(Variant variant) {
    Color? chipColor;
    final rawValue = variant.value;
    if (rawValue != null && rawValue.isNotEmpty) {
      try {
        chipColor = Color(
          int.parse('FF${rawValue.replaceAll('#', '')}', radix: 16),
        );
      } catch (_) {
        chipColor = null;
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: Mycolor.gery),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (chipColor != null) ...[
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: chipColor,
                ),
              ),
              const SizedBox(width: 4),
            ],
            Text(
              variant.name ?? '',
              style: const TextStyle(fontFamily: 'sm', fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Icon(icon, size: 16),
      ),
    );
  }
}
