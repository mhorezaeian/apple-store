final class PriceFormatter {
  const PriceFormatter._();

  static String format(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)},',
    );
  }

  static String discountPercent(int price, int discountPrice) {
    if (price <= 0 || discountPrice <= 0) {
      return '0';
    }

    return ((discountPrice / price) * 100).round().toString();
  }

  static int finalPrice(int price, int discountPrice) {
    return price - discountPrice;
  }
}
