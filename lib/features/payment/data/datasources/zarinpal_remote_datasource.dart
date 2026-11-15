// import 'dart:async';

// import 'package:apple_store/core/config/payment_config.dart';
// import 'package:apple_store/core/error/exceptions.dart';
// import 'package:apple_store/features/payment/data/datasources/payment_remote_datasource.dart';
// import 'package:apple_store/features/payment/data/models/payment_result_model.dart';
// import 'package:apple_store/features/payment/data/models/payment_session_model.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
import 'package:zarinpal/zarinpal.dart';

// /// تنها کلاسی که پکیج zarinpal را می‌شناسد.
// /// پکیج با callback کار می‌کند؛ با Completer آن را به Future تبدیل می‌کنیم
// /// تا بقیه‌ی اپ از جزئیات پکیج بی‌خبر بماند (الگوی Adapter).
// class ZarinpalRemoteDatasource implements PaymentRemoteDatasource {
//   final PaymentConfig _config;

//   /// اپ با «تومان» کار می‌کند و زرین‌پال «ریال» می‌خواهد.
//   /// این تنها نقطه‌ی تبدیل واحد در کل پروژه است.
//   /// بعد از اولین تست در Sandbox، مبلغ صفحه‌ی درگاه را چک کن
//   /// (مثلاً سبد ۱۰۰٬۰۰۰ تومان باید ۱٬۰۰۰٬۰۰۰ ریال نشان دهد).
//   static const int _rialPerToman = 10;

//   /// اگر callback هیچ‌وقت صدا زده نشود، Future برای همیشه معلق نماند
//   static const Duration _timeout = Duration(seconds: 30);

// ZarinpalRemoteDatasource(this._config);

//   /// ساخت PaymentRequest از تنظیمات تزریق‌شده
//   PaymentRequest _buildRequest(int amountToman, String description) {
//     return PaymentRequest()
//       ..setIsSandBox(_config.isSandbox)
//       ..setMerchantID(_config.merchantId)
//       ..setCallbackURL(_config.callbackUrl)
//       ..setAmount(amountToman * _rialPerToman)
//       ..setDescription(description);
//   }

//   @override
//   Future<PaymentSessionModel> request(int amount, String description) {
//     final completer = Completer<PaymentSessionModel>();
//     final request = _buildRequest(amount, description);
//     _debugDirectRequest(); // موقت: فقط برای عیب‌یابی، بعد از پیدا شدن علت حذفش کن

// ZarinPal().startPayment(request, (
//       int? status,
//       String? paymentGatewayUri,
//       Map<String, dynamic> data,
//     ) {
//       // اگر callback دو بار صدا زده شد، complete دوباره exception می‌دهد
//       debugPrint(
//         'Zarinpal start -> status: $status, uri: $paymentGatewayUri, data: $data',
//       );
//       if (completer.isCompleted) return;

//       // کد ۱۰۰ یعنی درخواست موفق بود
//       if (status == 100 && paymentGatewayUri != null) {
//         completer.complete(
//           PaymentSessionModel(
//             // آدرس به شکل .../StartPay/{authority} است.
//             // این وابستگی به فرمت زرین‌پال باید همین‌جا محبوس بماند.
//             authority: Uri.parse(paymentGatewayUri).pathSegments.last,
//             gatewayUrl: paymentGatewayUri,
//           ),
//         );
//       } else {
//         completer.completeError(
//           PaymentException(
//             message: 'ساخت درخواست پرداخت ناموفق بود (کد $status).',
//             error: data,
//           ),
//         );
//       }
//     });

//     return completer.future.timeout(
//       _timeout,
//       onTimeout: () => throw const PaymentException(
//         message: 'پاسخی از درگاه دریافت نشد. دوباره تلاش کنید.',
//       ),
//     );
//   }

//   @override
//   Future<PaymentResultModel> verify({
//     required String authority,
//     required String status,
//     required int amount,
//   }) {
//     final completer = Completer<PaymentResultModel>();
//     final request = _buildRequest(amount, 'verify');

//     ZarinPal().verificationPayment(status, authority, request, (
//       isPaymentSuccess,
//       refId,
//       paymentRequest,
//       data,
//     ) {
//       if (completer.isCompleted) return;
//       completer.complete(
//         PaymentResultModel(
//           isSuccess: isPaymentSuccess,
//           refId: refId?.toString(),
//         ),
//       );
//     });

//     return completer.future.timeout(
//       _timeout,
//       onTimeout: () => throw const PaymentException(
//         message: 'تأیید پرداخت با تأخیر مواجه شد. دوباره تلاش کنید.',
//       ),
//     );
//   }

//   // موقت: فقط برای عیب‌یابی، بعد از پیدا شدن علت حذفش کن
//   Future<void> _debugDirectRequest() async {
//     try {
//       final response = await Dio().post(
//         'https://sandbox.zarinpal.com/pg/v4/payment/request.json',
//         data: {
//           'merchant_id': _config.merchantId,
//           'amount': 100000, // ریال
//           'callback_url': _config.callbackUrl,
//           'description': 'debug',
//         },
//         options: Options(headers: {'Accept': 'application/json'}),
//       );
//       debugPrint('DIRECT OK: ${response.data}');
//     } on DioException catch (e) {
//       debugPrint(
//         'DIRECT ERROR: ${e.type} | ${e.message} | '
//         '${e.response?.statusCode} | ${e.response?.data}',
//       );
//     }
//   }
// }
import 'package:apple_store/core/config/payment_config.dart';
import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/features/payment/data/datasources/payment_remote_datasource.dart';
import 'package:apple_store/features/payment/data/models/payment_result_model.dart';
import 'package:apple_store/features/payment/data/models/payment_session_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// تنها کلاسی که با API زرین‌پال (نسخه‌ی v4 REST) حرف می‌زند.
/// به‌جای پکیج zarinpal مستقیم از Dio استفاده می‌کنیم؛
/// چون پکیج در تست با خطای بی‌صدا (status 0) شکست می‌خورد.
/// Dio تزریق می‌شود تا در تست بشود آن را mock کرد.
class ZarinpalRemoteDatasource implements PaymentRemoteDatasource {
  final PaymentConfig _config;
  final Dio _dio;

  /// اپ با «تومان» کار می‌کند و زرین‌پال «ریال» می‌خواهد.
  /// تنها نقطه‌ی تبدیل واحد در کل پروژه همین‌جاست.
  static const int _rialPerToman = 10;

  /// سقف مبلغ هر تراکنش (ریال) طبق پاسخ سرور زرین‌پال در سندباکس.
  /// برای مرچنت واقعی ممکن است متفاوت باشد؛ با پنل زرین‌پال چک کن.
  static const int _maxAmountRial = 2000000000;

  /// کد ۱۰۰: موفق. کد ۱۰۱: قبلاً verify شده (برای verify تکراری هم موفق حساب می‌شود).
  static const int _successCode = 100;
  static const int _alreadyVerifiedCode = 101;

  ZarinpalRemoteDatasource(this._config, this._dio);

  /// آدرس API و آدرس صفحه‌ی پرداخت، بر اساس حالت Sandbox یا واقعی
  String get _apiBase => _config.isSandbox
      ? 'https://sandbox.zarinpal.com'
      : 'https://payment.zarinpal.com';

  String get _payBase => _config.isSandbox
      ? 'https://sandbox.zarinpal.com'
      : 'https://www.zarinpal.com';

  @override
  Future<PaymentSessionModel> request(int amount, String description) async {
    final amountRial = amount * _rialPerToman;
    if (amountRial > _maxAmountRial) {
      throw PaymentException(
        message: 'مبلغ تراکنش از سقف مجاز بیشتر است.',
        error: {'amount': amountRial, 'max': _maxAmountRial},
      );
    }

    final body = await _post('/pg/v4/payment/request.json', {
      'merchant_id': _config.merchantId,
      'amount': amount * _rialPerToman,
      'callback_url': _config.callbackUrl,
      'description': description,
    });

    final data = body['data'];
    if (data is Map && data['code'] == _successCode) {
      final authority = data['authority'];
      if (authority is String && authority.isNotEmpty) {
        return PaymentSessionModel(
          authority: authority,
          gatewayUrl: '$_payBase/pg/StartPay/$authority',
        );
      }
    }
    debugPrint(
      'Zarinpal request failed -> toman: $amount, rial: ${amount * _rialPerToman}, body: $body',
    );
    throw PaymentException(
      message: _errorMessage(body, 'ساخت درخواست پرداخت ناموفق بود.'),
      error: body,
    );
  }

  @override
  Future<PaymentResultModel> verify({
    required String authority,
    required String status,
    required int amount,
  }) async {
    final body = await _post('/pg/v4/payment/verify.json', {
      'merchant_id': _config.merchantId,
      'amount': amount * _rialPerToman, // دقیقاً همان مبلغ درخواست اولیه
      'authority': authority,
    });

    final data = body['data'];
    if (data is Map) {
      final code = data['code'];
      if (code == _successCode || code == _alreadyVerifiedCode) {
        return PaymentResultModel(
          isSuccess: true,
          refId: data['ref_id']?.toString(),
        );
      }
    }

    // درگاه جواب داده ولی پرداخت تأیید نشد (مثلاً مبلغ نخواند)
    return const PaymentResultModel(isSuccess: false);
  }

  /// ارسال POST و برگرداندن بدنه‌ی JSON.
  /// زرین‌پال برای خطاها گاهی همراه HTTP 4xx هم بدنه‌ی JSON می‌دهد؛
  /// آن را برمی‌گردانیم تا کد خطای واقعی دیده شود.
  Future<Map<String, dynamic>> _post(
    String path,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '$_apiBase$path',
        data: body,
        options: Options(headers: {'Accept': 'application/json'}),
      );
      return response.data ?? const {};
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) return data;

      throw PaymentException(
        message: 'ارتباط با درگاه برقرار نشد. اینترنت (و VPN) را بررسی کنید.',
        error: e,
      );
    }
  }

  /// پیام قابل نمایش؛ کد خطای زرین‌پال را برای پیگیری کنارش می‌گذاریم.
  String _errorMessage(Map<String, dynamic> body, String fallback) {
    final errors = body['errors'];
    if (errors is Map && errors['code'] != null) {
      return '$fallback (کد ${errors['code']})';
    }
    return fallback;
  }
}
