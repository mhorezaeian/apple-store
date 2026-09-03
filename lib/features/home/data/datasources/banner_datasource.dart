import 'package:apple_store/features/home/data/models/banner_model.dart';

abstract interface class BannerDatasource {
  Future<List<BannerModel>> getBaners();
}
