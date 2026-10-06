import 'package:apple_store/core/error/exceptions.dart';
import 'package:apple_store/features/product/data/datasources/product_datasource.dart';
import 'package:apple_store/features/product/data/models/product_model.dart';
import 'package:apple_store/features/product/data/models/variant_model.dart';
import 'package:apple_store/features/product/data/models/variant_type_model.dart';
import 'package:apple_store/features/product_category/data/models/product_category_model.dart';
import 'package:dio/dio.dart';

class ProductRemoteDatasource implements ProductDatasource {
  final Dio _dio;

  ProductRemoteDatasource(this._dio);

  //getAllProducts
  @override
  Future<List<ProductModel>> getAllProducts() async {
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

  //getBestSellerProducts
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

  //getHotestProducts
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

  // getProduct use id
  @override
  Future<ProductModel> getProduct(String id) async {
    // TODO: implement getProduct
    try {
      Map<String, String> qParams = {'filter': 'id= "${id}"'};
      final response = await _dio.get(
        'collections/products/records',
        queryParameters: qParams,
      );

      final ProductModel product = ProductModel.fromMap(
        Map<String, dynamic>.from(response.data['items'][0]),
      );

      return product;
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
  Future<VariantTypeModel> getVariantType(String variantTypeId) async {
    Map<String, String> qParams = {'filter': 'id= "${variantTypeId}"'};

    try {
      final response = await _dio.get(
        'collections/variants_type/records',
        queryParameters: qParams,
      );
      if (response.data['items'].isEmpty) {
        throw ServerException(
          statusCode: 404,
          message: 'VariantType not found: $variantTypeId',
          body: {},
        );
      }

      final VariantTypeModel vTypes = VariantTypeModel.fromMap(
        Map<String, dynamic>.from(response.data['items'][0]),
      );

      return vTypes;
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
  Future<List<VariantModel>> getVariants(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id= "${productId}"'};
      final response = await _dio.get(
        'collections/variants/records',
        queryParameters: qParams,
      );

      final List<VariantModel> variants = response.data['items']
          .map<VariantModel>((map) => VariantModel.fromMap(map))
          .toList();

      return variants;
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
  Future<ProductCategoryModel> getProductCategory(
    String productCategoryId,
  ) async {
    Map<String, String> qParams = {'filter': 'id= "${productCategoryId}"'};

    try {
      final response = await _dio.get(
        'collections/category/records',
        queryParameters: qParams,
      );
      if (response.data['items'].isEmpty) {
        throw ServerException(
          statusCode: 404,
          message: 'VariantType not found: $productCategoryId',
          body: {},
        );
      }

      final ProductCategoryModel category = ProductCategoryModel.fromMap(
        Map<String, dynamic>.from(response.data['items'][0]),
      );

      return category;
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
  Future<List<ProductModel>> getProductsByCategory(String caregoryId) async {
    Map<String, String> qParams = {};
    if (caregoryId != 'qnbj8d6b9lzzpn8') {
      qParams = {'filter': 'category= "${caregoryId}"'};
    }

    try {
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
