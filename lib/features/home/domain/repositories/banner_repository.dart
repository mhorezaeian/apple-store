import 'package:apple_store/core/error/failures.dart';
import 'package:apple_store/features/home/domain/entities/banner.dart';
import 'package:dartz/dartz.dart';

abstract interface class BannerRepository {
  Future<Either<Failure, List<Banner>>> getBanners();
}
