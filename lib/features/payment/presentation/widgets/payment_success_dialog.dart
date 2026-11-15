import 'package:apple_store/features/orders/presentation/pages/orders_screen.dart';
import 'package:flutter/material.dart';

/// دیالوگ پرداخت موفق با دو گزینه: «متوجه شدم» و «مشاهده خرید»
void showPaymentSuccessDialog(BuildContext context, String refId) {
  showDialog(
    context: context,
    barrierDismissible: false, // کاربر باید یکی از گزینه‌ها را انتخاب کند
    builder: (dialogContext) => Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('پرداخت موفق', style: TextStyle(fontFamily: 'sb')),
          ],
        ),
        content: Text(
          'کد پیگیری: $refId',
          style: const TextStyle(fontFamily: 'sm'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('متوجه شدم', style: TextStyle(fontFamily: 'sm')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext); // اول دیالوگ را ببند
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const OrdersScreen()));
            },
            child: const Text(
              'مشاهده خرید',
              style: TextStyle(fontFamily: 'sm'),
            ),
          ),
        ],
      ),
    ),
  );
}
