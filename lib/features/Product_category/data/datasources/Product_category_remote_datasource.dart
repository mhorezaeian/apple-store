import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/features/Product_category/data/datasources/Product_category_datasource.dart';
import 'package:apple_store/features/Product_category/data/models/Product_category_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/foundation/annotations.dart';

class ProductCategoryRemoteDatasource implements ProductCategoryDatasource {
  final Dio _dio;

  ProductCategoryRemoteDatasource(this._dio);

  @override
  Future<List<ProductCategory>> getCategories() async {
    try {
      final responce = await _dio.get('collections/category/records');
      return responce.data['items']
          .map<ProductCategory>(
            (jsonObject) => ProductCategory.fromJson(jsonObject),
          )
          .toList();
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
    }
    // } on DioException catch (ex) {
    //   throw ApiException(
    //     statusCode: ex.response?.statusCode ?? 000,
    //     message: ex.response?.data.toString() ?? "Api arror",
    //     body: ex.response?.data is Map
    //         ? Map<String, dynamic>.from(ex.response!.data)
    //         : {},
    //   );
    // }
    catch (ex) {
      throw UnKnownException(message: ex.toString());
    }
  }
}
