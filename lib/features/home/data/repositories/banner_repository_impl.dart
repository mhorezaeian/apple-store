import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/home/data/datasources/banner_datasource.dart';
import 'package:apple_store/features/home/domain/entities/banner.dart';
import 'package:apple_store/features/home/domain/repositories/banner_repository.dart';
import 'package:dartz/dartz.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerDatasource _datasource;

  BannerRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, List<Banner>>> getBanners() async {
    try {
      final BannerModels = await _datasource.getBaners();
      final banners = BannerModels.map((model) => model.toEntity()).toList();
      return right(banners);
    } on NetworkException catch (e) {
      return left(
        NetworkFailure(message: 'اتصال به اینترنت یا سرور برقرار نشد'),
      );
    } on ServerException catch (e) {
      return left(ServerFailure(message: 'خطای غیرمنتظره‌ای رخ داد'));
    } on UnKnownException catch (e) {
      return left(UnknownFailure(message: e.toString()));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }
}
