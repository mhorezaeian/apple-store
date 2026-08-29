import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/features/product_category/data/datasources/product_category_datasource.dart';
import 'package:apple_store/features/product_category/data/models/product_category_model.dart';
import 'package:dio/dio.dart';

class ProductCategoryRemoteDatasource implements ProductCategoryDatasource {
  final Dio _dio;

  ProductCategoryRemoteDatasource(this._dio);

  @override
  Future<List<ProductCategoryModel>> getCategories() async {
    try {
      final responce = await _dio.get('collections/category/records');

      final List<ProductCategoryModel> models = responce.data['items']
          .map<ProductCategoryModel>(
            (jsonObject) => ProductCategoryModel.fromMap(jsonObject),
          )
          .toList();

      return models;
    } on DioException catch (ex) {
      switch (ex.type) {
        case DioExceptionType.connectionError:
          throw NetworkException(message: 'No internet connection');

        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw NetworkException(message: 'Connection timeout');

        default:
          throw ApiException(
            statusCode: ex.response?.statusCode,
            message: ex.response?.data?.toString() ?? 'API error',
            body: ex.response?.data is Map
                ? Map<String, dynamic>.from(ex.response!.data)
                : {},
          );
      }
    } catch (ex) {
      throw UnKnownException(message: '${ex.toString()} fuck');
    }
  }
}
