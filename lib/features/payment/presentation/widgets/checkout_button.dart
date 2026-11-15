import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/core/utils/price_formatter.dart';
import 'package:apple_store/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// دکمه‌ی «ادامه فرآیند خرید».
/// فقط state پرداخت را می‌بیند و یک event می‌فرستد؛ از زرین‌پال چیزی نمی‌داند.
class CheckoutButton extends StatelessWidget {
  final bool hasItems;
  final int total;

  const CheckoutButton({
    super.key,
    required this.hasItems,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        // دفاع اول در برابر کلیک تکراری: هنگام کار، دکمه غیرفعال است
        final busy = state is PaymentLoading || state is PaymentVerifying;

        return ElevatedButton(
          // null بودن onPressed یعنی دکمه غیرفعال
          onPressed: (!hasItems || busy)
              ? null
              : () => context.read<PaymentBloc>().add(const PaymentStarted()),
          style: ElevatedButton.styleFrom(
            backgroundColor: Mycolor.green,
            disabledBackgroundColor: Mycolor.gery,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: busy
              ? const _Spinner()
              : _Label(hasItems: hasItems, total: total),
        );
      },
    );
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner();

  @override
  Widget build(BuildContext context) => const SizedBox(
    width: 22,
    height: 22,
    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
  );
}

class _Label extends StatelessWidget {
  final bool hasItems;
  final int total;
  const _Label({required this.hasItems, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'ادامه فرآیند خرید',
          style: TextStyle(fontFamily: 'sb', fontSize: 16, color: Colors.white),
        ),
        if (hasItems) ...[
          const SizedBox(width: 12),
          Text(
            '${PriceFormatter.format(total)} تومان',
            style: const TextStyle(
              fontFamily: 'sb',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ],
    );
  }
}
