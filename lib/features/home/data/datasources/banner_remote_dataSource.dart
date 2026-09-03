import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/features/home/data/datasources/banner_datasource.dart';
import 'package:apple_store/features/home/data/models/banner_model.dart';
import 'package:dio/dio.dart';

class BannerRemoteDatasource implements BannerDatasource {
  final Dio _dio;

  BannerRemoteDatasource(this._dio);
  @override
  Future<List<BannerModel>> getBaners() async {
    try {
      final response = await _dio.get('collections/banner/records');
      final List<BannerModel> banners = response.data['items']
          .map<BannerModel>((map) => BannerModel.fromMap(map))
          .toList();
      return banners;
    } on DioException catch (ex) {
      switch (ex.type) {
        case DioExceptionType.connectionError:
          throw NetworkException(message: 'No internet connection');

        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw NetworkException(message: 'Connection timeout');

        default:
          throw ServerException(
            statusCode: ex.response?.statusCode,
            message: ex.response?.data?.toString() ?? 'API error',
            body: ex.response?.data is Map
                ? Map<String, dynamic>.from(ex.response!.data)
                : {},
          );
      }
    } catch (ex) {
      throw UnKnownException(
        message: '${ex.toString()} fucking UnKnownException',
      );
    }
  }
}
