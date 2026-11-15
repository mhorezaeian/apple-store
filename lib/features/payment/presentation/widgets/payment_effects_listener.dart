import 'package:apple_store/features/basket/presentation/bloc/BasketBloc/basket_bloc.dart';
import 'package:apple_store/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:apple_store/features/payment/presentation/widgets/payment_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

/// واکنش به stateهای پرداخت با «اثر جانبی»: باز کردن مرورگر، دیالوگ و SnackBar.
///
/// BlocListener برای کارهایی است که یک‌بار انجام می‌شوند (اثر جانبی)،
/// BlocBuilder برای ساخت UI. این دو را قاطی نمی‌کنیم.
///
/// مهم: این ویجت در main دور Scaffold (داخل home) قرار می‌گیرد، نه داخل BasketScreen؛
/// چون BasketScreen داخل IndexedStack همیشه زنده است و دیالوگ باید مستقل از تب فعلی دیده شود.
class PaymentEffectsListener extends StatelessWidget {
  final Widget child;
  const PaymentEffectsListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) async {
        switch (state) {
          case PaymentRedirect(:final url):
            await _openGateway(context, url);
          case PaymentSuccess(:final refId):
            // سبد در Hive خالی شده؛ BasketBloc دوباره بخواند تا UI خالی شود
            context.read<BasketBloc>().add(const BasketRefreshed());
            showPaymentSuccessDialog(context, refId);
          case PaymentFailed(:final message):
            _showMessage(context, message);
          default:
            break; // Initial, Loading, Verifying: کاری لازم نیست
        }
      },
      child: child,
    );
  }

  /// باز کردن درگاه در مرورگر خارجی (کار پلتفرم است، نه Domain)
  Future<void> _openGateway(BuildContext context, String url) async {
    final opened = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    // بعد از هر await باید مطمئن شویم ویجت هنوز زنده است
    if (!opened && context.mounted) {
      _showMessage(context, 'امکان باز کردن درگاه پرداخت وجود ندارد.');
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontFamily: 'sm')),
      ),
    );
  }
}
