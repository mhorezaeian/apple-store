import 'dart:async';

import 'package:app_links/app_links.dart';

/// تنها مسئولیت: شنیدن لینک‌های ورودی و استخراج پارامترهای بازگشت از درگاه.
/// این کلاس از Bloc و UI خبر ندارد؛ فقط یک callback صدا می‌زند (Dependency Inversion).
class DeepLinkService {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _subscription;

  /// [onPayment] هر وقت لینکی با Authority و Status رسید صدا زده می‌شود.
  /// باید یک‌بار و در بالاترین سطح اپ (main) صدا زده شود، نه داخل یک صفحه؛
  /// چون اگر اپ با لینک باز شود (cold start) آن صفحه شاید هنوز ساخته نشده باشد.
  void init(void Function(String authority, String status) onPayment) {
    // اگر init دوباره صدا زده شد، listener قبلی دوتایی نشود
    _subscription?.cancel();

    _subscription = _appLinks.uriLinkStream.listen((uri) {
      // زرین‌پال کلیدها را با حرف بزرگ می‌فرستد (Authority و Status)؛
      // lowerCase می‌کنیم تا به بزرگی و کوچکی حروف حساس نباشیم.
      final params = {
        for (final entry in uri.queryParameters.entries)
          entry.key.toLowerCase(): entry.value,
      };

      final authority = params['authority'];
      final status = params['status'];

      // فقط لینکی که هر دو پارامتر را دارد «بازگشت از درگاه» حساب می‌شود
      if (authority != null && status != null) {
        onPayment(authority, status);
      }
    });
  }

  /// جلوگیری از memory leak
  void dispose() => _subscription?.cancel();
}
