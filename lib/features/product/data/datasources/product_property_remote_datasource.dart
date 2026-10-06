import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/features/product/data/datasources/product_property_datasource.dart';
import 'package:apple_store/features/product/data/models/product_property_model.dart';
import 'package:dio/dio.dart';

class ProductPropertyRemoteDatasource implements ProductPropertyDatasource {
  final Dio _dio;
  ProductPropertyRemoteDatasource(this._dio);
  @override
  Future<List<ProductPropertyModel>> getProductProperty(
    String propertyId,
  ) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id= "${propertyId}"'};
      final response = await _dio.get(
        'collections/properties/records',
        queryParameters: qParams,
      );

      final List<ProductPropertyModel> pProperty = response.data['items']
          .map<ProductPropertyModel>((map) => ProductPropertyModel.fromMap(map))
          .toList();

      return pProperty;
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
