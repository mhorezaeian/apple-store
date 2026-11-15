import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/core/di/di.dart';
import 'package:apple_store/core/utils/price_formatter.dart';
import 'package:apple_store/core/widgets/falilure_state_widget.dart';
import 'package:apple_store/features/orders/domain/entities/order.dart';
import 'package:apple_store/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// صفحه «سابقه خرید».
/// Bloc همین‌جا ساخته می‌شود و با باز شدن صفحه، سفارش‌ها خوانده می‌شوند.
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<OrdersBloc>()..add(const OrdersStarted()),
      // اپ جهت‌دهی راست‌به‌چپ ندارد، پس برای این صفحه RTL می‌گذاریم
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Mycolor.backgroundScreenColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'سابقه خرید',
              style: TextStyle(fontFamily: 'sb', fontSize: 16),
            ),
          ),
          body: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              if (state is OrdersInitial || state is OrdersLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is OrdersError) {
                return FailureStateWidget(
                  message: state.message,
                  onRetry: () =>
                      context.read<OrdersBloc>().add(const OrdersRefreshed()),
                );
              }

              final orders = (state as OrdersLoaded).orders;
              if (orders.isEmpty) {
                return const Center(
                  child: Text(
                    'هنوز خریدی انجام نداده‌اید',
                    style: TextStyle(fontFamily: 'sm', fontSize: 14),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) =>
                    _OrderTile(order: orders[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// نمایش یک سفارش
class _OrderTile extends StatelessWidget {
  final Order order;
  const _OrderTile({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 20),
              const SizedBox(width: 8),
              Text(
                'کد پیگیری: ${order.id}',
                style: const TextStyle(fontFamily: 'sb', fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${order.items.length} کالا  •  ${_formatDate(order.date)}',
            style: const TextStyle(fontFamily: 'sm', fontSize: 12),
          ),
          const Divider(height: 20),
          Text(
            '${PriceFormatter.format(order.total)} تومان',
            style: const TextStyle(fontFamily: 'sb', fontSize: 14),
          ),
        ],
      ),
    );
  }

  /// تاریخ میلادی ساده (برای تاریخ شمسی بعداً پکیج اضافه می‌شود)
  String _formatDate(DateTime date) =>
      date.toLocal().toString().substring(0, 16);
}
