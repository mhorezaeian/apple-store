import 'package:apple_store/features/basket/data/models/basket_item_model.dart';
import 'package:apple_store/features/payment/domain/entities/pending_payment.dart';
import 'package:hive/hive.dart';

// فایل pending_payment_model.g.dart را build_runner می‌سازد
part 'pending_payment_model.g.dart';

/// Model ذخیره‌ی تراکنش در انتظار (Hive). typeId یکتا: ۱۱
@HiveType(typeId: 11)
class PendingPaymentModel {
  @HiveField(0)
  final String authority;

  @HiveField(1)
  final int amount;

  @HiveField(2)
  final List<BasketItemModel> items;

  PendingPaymentModel({
    required this.authority,
    required this.amount,
    required this.items,
  });

  /// Entity ← Model
  factory PendingPaymentModel.fromEntity(PendingPayment entity) {
    return PendingPaymentModel(
      authority: entity.authority,
      amount: entity.amount,
      items: entity.items.map(BasketItemModel.fromEntity).toList(),
    );
  }

  /// Model → Entity
  PendingPayment toEntity() {
    return PendingPayment(
      authority: authority,
      amount: amount,
      items: items.map((item) => item.toEntity()).toList(),
    );
  }
}
