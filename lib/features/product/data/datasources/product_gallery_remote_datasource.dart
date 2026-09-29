import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/features/product/data/datasources/product_gallery_datasource.dart';
import 'package:apple_store/features/product/data/models/product_image_model.dart';
import 'package:apple_store/features/product/domain/entities/product_image.dart';
import 'package:apple_store/features/product_category/data/models/product_category_model.dart';
import 'package:dio/dio.dart';

class ProductGalleryRemoteDatasource implements ProductGalleryDatasource {
  final Dio _dio;

  ProductGalleryRemoteDatasource(this._dio);

  @override
  Future<List<ProductImageModel>> getProductGallery(String ProductId) async {
    // print('==> in image datasource');
    // print(ProductId);
    try {
      Map<String, String> qParams = {'filter': 'product_id= "${ProductId}"'};
      final response = await _dio.get(
        'collections/gallery/records',
        queryParameters: qParams,
      );
      // print(response.toString());s

      final List<ProductImageModel> productImageGallery = response.data['items']
          .map<ProductImageModel>((map) => ProductImageModel.fromMap(map))
          .toList();

      return productImageGallery;
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
