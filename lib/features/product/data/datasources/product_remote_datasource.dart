import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/features/product/data/datasources/product_datasource.dart';
import 'package:apple_store/features/product/data/models/product_model.dart';
import 'package:dio/dio.dart';

class ProductRemoteDatasource implements ProductDatasource {
  final Dio _dio;

  ProductRemoteDatasource(this._dio);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get('collections/products/records');

      final List<ProductModel> products = response.data['items']
          .map<ProductModel>((map) => ProductModel.fromMap(map))
          .toList();

      return products;
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

  @override
  Future<List<ProductModel>> getBestSellerProducts() async {
    try {
      Map<String, String> qParams = {'filter': 'popularity= "Hotest"'};
      final response = await _dio.get(
        'collections/products/records',
        queryParameters: qParams,
      );

      final List<ProductModel> products = response.data['items']
          .map<ProductModel>((map) => ProductModel.fromMap(map))
          .toList();

      return products;
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

  @override
  Future<List<ProductModel>> getHotestProducts() async {
    try {
      Map<String, String> qParams = {'filter': 'popularity= "Best Seller"'};
      final response = await _dio.get(
        'collections/products/records',
        queryParameters: qParams,
      );

      final List<ProductModel> products = response.data['items']
          .map<ProductModel>((map) => ProductModel.fromMap(map))
          .toList();

      return products;
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
