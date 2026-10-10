import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/core/utils/price_formatter.dart';
import 'package:apple_store/core/widgets/falilure_state_widget.dart';
import 'package:apple_store/features/basket/domain/entities/basket_item.dart'
    as domain;
import 'package:apple_store/features/basket/presentation/bloc/basket_bloc.dart';
import 'package:apple_store/features/basket/presentation/widgets/basket_item.dart';
import 'package:apple_store/widgets/tittle_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  child: ElevatedButton(
                    onPressed: items.isEmpty ? null : () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Mycolor.green,
                      disabledBackgroundColor: Mycolor.gery,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ادامه فرآیند خرید',
                          style: TextStyle(
                            fontFamily: 'sb',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        if (items.isNotEmpty) ...[
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
                    ),
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
    context.read<BasketBloc>().add(
      BasketItemAdded(
        domain.BasketItem(
          productId: item.productId,
          name: item.name,
          price: item.price,
          discountPrice: item.discountPrice,
          thumbnail: item.thumbnail,
          quantity: 1,
          variants: item.variants,
        ),
      ),
    );
  }

  void _decrement(BuildContext context, domain.BasketItem item) {
    final itemId = item.id;
    if (itemId == null) {
      return;
    }

    final currentQuantity = item.quantity ?? 1;
    if (currentQuantity <= 1) {
      context.read<BasketBloc>().add(BasketItemRemoved(itemId));
      return;
    }

    context.read<BasketBloc>().add(
      BasketItemUpdated(
        domain.BasketItem(
          id: item.id,
          productId: item.productId,
          name: item.name,
          price: item.price,
          discountPrice: item.discountPrice,
          thumbnail: item.thumbnail,
          quantity: currentQuantity - 1,
          variants: item.variants,
        ),
      ),
    );
  }

  void _remove(BuildContext context, domain.BasketItem item) {
    final itemId = item.id;
    if (itemId == null) {
      return;
    }
    context.read<BasketBloc>().add(BasketItemRemoved(itemId));
  }
}
