import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/features/payment/data/datasources/pending_payment_datasource.dart';
import 'package:apple_store/features/payment/data/models/pending_payment_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// ذخیره‌ی تراکنش‌های در انتظار در Hive: authority ← snapshot
class PendingPaymentLocalDataSource implements PendingPaymentDatasource {
  final Box<PendingPaymentModel> pendingBox;

  PendingPaymentLocalDataSource({required this.pendingBox});

  @override
  Future<void> save(PendingPaymentModel pending) async {
    try {
      // کلید = authority؛ هر تراکنش رکورد مستقل خودش را دارد
      await pendingBox.put(pending.authority, pending);
    } catch (e) {
      throw LocalStorageException(
        message: 'Failed to save pending payment.',
        error: e,
      );
    }
  }

  @override
  PendingPaymentModel? get(String authority) {
    try {
      return pendingBox.get(authority);
    } catch (e) {
      throw LocalStorageException(
        message: 'Failed to read pending payment.',
        error: e,
      );
    }
  }

  /// فقط همین تراکنش پاک می‌شود، نه کل box
  @override
  Future<void> delete(String authority) async {
    try {
      await pendingBox.delete(authority);
    } catch (e) {
      throw LocalStorageException(
        message: 'Failed to delete pending payment.',
        error: e,
      );
    }
  }
}
