import 'package:apple_store/core/utils/price_formatter.dart';
import 'package:apple_store/core/widgets/falilure_state_widget.dart';
import 'package:apple_store/features/basket/domain/entities/basket_item.dart'
    as domain;
import 'package:apple_store/features/basket/presentation/bloc/BasketBloc/basket_bloc.dart';
import 'package:apple_store/features/basket/presentation/widgets/basket_item.dart';
import 'package:apple_store/features/payment/presentation/widgets/checkout_button.dart';
import 'package:apple_store/widgets/tittle_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// صفحه سبد خرید.
/// دیگر هیچ منطق پرداختی اینجا نیست: دکمه (CheckoutButton) به PaymentBloc می‌گوید
/// «پرداخت را شروع کن» و نتیجه را PaymentEffectsListener در ریشه‌ی اپ مدیریت می‌کند.
class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        if (state is BasketInitial || state is BasketLoading) {
          return const SafeArea(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is BasketError) {
          return SafeArea(
            child: Column(
              children: [
                TittleAppBar(title: 'سبد خرید'),
                Expanded(
                  child: FailureStateWidget(
                    message: state.message,
                    onRetry: () {
                      context.read<BasketBloc>().add(const BasketRefreshed());
                    },
                  ),
                ),
              ],
            ),
          );
        }

        final items = state is BasketLoaded
            ? state.items
            : <domain.BasketItem>[];
        final total = PriceFormatter.basketTotal(items);

        return SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: TittleAppBar(title: 'سبد خرید')),
                  if (items.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          'سبد خرید شما خالی است',
                          style: TextStyle(fontFamily: 'sm', fontSize: 14),
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: items.length,
                        (context, index) {
                          final item = items[index];
                          return BasketItem(
                            item: item,
                            onIncrement: () => _increment(context, item),
                            onDecrement: () => _decrement(context, item),
                            onRemove: () => _remove(context, item),
                          );
                        },
                      ),
                    ),
                  // فضای خالی تا آیتم آخر زیر دکمه پنهان نشود
                  const SliverPadding(padding: EdgeInsets.only(bottom: 60)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 44.0,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 53,
                  child: CheckoutButton(
                    hasItems: items.isNotEmpty,
                    total: total,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _increment(BuildContext context, domain.BasketItem item) {
    if (item.id == null) return;

    context.read<BasketBloc>().add(
      BasketItemUpdated(item.copyWith(quantity: item.quantity + 1)),
    );
  }

  void _decrement(BuildContext context, domain.BasketItem item) {
    final itemId = item.id;
    if (itemId == null) return;

    // اگر تعداد ۱ بود، کاهش یعنی حذف
    if (item.quantity <= 1) {
      context.read<BasketBloc>().add(BasketItemRemoved(itemId));
      return;
    }

    context.read<BasketBloc>().add(
      BasketItemUpdated(item.copyWith(quantity: item.quantity - 1)),
    );
  }

  void _remove(BuildContext context, domain.BasketItem item) {
    final itemId = item.id;
    if (itemId == null) return;
    context.read<BasketBloc>().add(BasketItemRemoved(itemId));
  }
}
