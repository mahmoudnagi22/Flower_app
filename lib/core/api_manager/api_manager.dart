import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/core/resources/constants_manager.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/app_sections/categories/data/models/categories_dto.dart';
import 'package:flower_app/features/app_sections/categories/data/models/category_by_id_dto.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/product_filter.dart';
import 'package:flower_app/features/app_sections/home/best_seller/data/model/best_seller_model.dart';
import 'package:flower_app/features/app_sections/home/data/model/HomeDataResponse.dart';
import 'package:flower_app/features/app_sections/occasions/data/models/occasions_dto.dart';
import 'package:flower_app/features/app_sections/occasions/data/models/products_dto.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_request_dto.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_response_dto.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiManager {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  // Centralized network checker
  Future<bool> _isConnected() async {
    final result = await Connectivity().checkConnectivity();
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.vpn;
  }

  // Centralized request handler
  Future<ApiResult<T>> _handleRequest<T>(
      Future<Response?> request,
      T Function(Map<String, dynamic>) fromJson,
      ) async {
    if (!await _isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(errorMessage: 'Please check your internet connection'),
      );
    }

    try {
      final response = await request;
      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return ApiSuccessResult(data: fromJson(response.data));
        } else {
          return ApiErrorResult(failures: ServerError(errorMessage: response.data.toString()));
        }
      } else {
        return ApiErrorResult(failures: ServerError(errorMessage: 'No response from server'));
      }
    } on DioException catch (e) {
      return ApiErrorResult(failures: ServerError(errorMessage: e.message ?? 'Unexpected error'));
    }
  }

  // GET method
  Future<Response?> getRequest(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await dio.get(endpoint, queryParameters: queryParameters);
    } on DioException catch (error) {
      print("GET Error: ${error.message}");
      return error.response;
    }
  }

  // POST method
  Future<Response?> postRequest(String endpoint, dynamic data, {Map<String, String>? headers}) async {
    try {
      return await dio.post(endpoint, data: data, options: Options(headers: headers));
    } on DioException catch (error) {
      print("POST Error: ${error.message}");
      return error.response;
    }
  }

  // PUT method
  Future<Response?> putRequest(String endpoint, dynamic data, {Map<String, String>? headers}) async {
    try {
      return await dio.put(endpoint, data: data, options: Options(headers: headers));
    } on DioException catch (error) {
      print("PUT Error: ${error.message}");
      return error.response;
    }
  }

  // PATCH method
  Future<Response?> patchRequest(String endpoint, dynamic data, {Map<String, String>? headers}) async {
    try {
      return await dio.patch(endpoint, data: data, options: Options(headers: headers));
    } on DioException catch (error) {
      print("PATCH Error: ${error.message}");
      return error.response;
    }
  }

  // DELETE method
  Future<Response?> deleteRequest(String endpoint, {Map<String, String>? headers}) async {
    try {
      return await dio.delete(endpoint, options: Options(headers: headers));
    } on DioException catch (error) {
      print("DELETE Error: ${error.message}");
      return error.response;
    }
  }

  // ==================== API METHODS ====================

  Future<ApiResult<SignupResponseDto>> signup(SignupRequestDto signup) async {
    return _handleRequest(
      postRequest(AppConstants.baseUrl + AppConstants.sinUp, signup.toJson()),
          (data) => SignupResponseDto.fromJson(data),
    );
  }

  Future<ApiResult<List<OccasionsDto>>> getOccasions() async {
    return _handleRequest(
      getRequest(AppConstants.baseUrl + AppConstants.occasions),
          (data) {
        final List<dynamic> jsonList = data['occasions'] ?? [];
        return jsonList.map((e) => OccasionsDto.fromJson(e)).toList();
      },
    );
  }

  Future<ApiResult<List<ProductModel>>> getBestSellers() async {
    return _handleRequest(
      getRequest(AppConstants.baseUrl + AppConstants.bestSeller),
          (data) {
        final List<dynamic> jsonList = data['bestSeller'] ?? [];
        return jsonList.map((e) => ProductModel.fromJson(e)).toList();
      },
    );
  }

  Future<ApiResult<OccasionDto>> getOccasionById(String occasionId) async {
    return _handleRequest(
      getRequest('${AppConstants.baseUrl}${AppConstants.occasions}/$occasionId'),
          (data) => OccasionDto.fromJson(data),
    );
  }

  Future<ApiResult<List<ProductDto>>> getProducts(ProductFilter filter) async {
    final Map<String, dynamic> queryParameters = {};
    if (filter.occasionId != null) queryParameters['occasion'] = filter.occasionId;
    if (filter.categoryId != null) queryParameters['category'] = filter.categoryId;

    return _handleRequest(
      getRequest('${AppConstants.baseUrl}${AppConstants.products}/', queryParameters: queryParameters),
          (data) {
        final List<dynamic> jsonList = data['products'] ?? [];
        return jsonList.map((e) => ProductDto.fromJson(e)).toList();
      },
    );
  }

  Future<ApiResult<List<CategoryDto>>> getCategories() async {
    return _handleRequest(
      getRequest(AppConstants.baseUrl + AppConstants.categories),
          (data) {
        final List<dynamic> jsonList = data['categories'] ?? [];
        return jsonList.map((e) => CategoryDto.fromJson(e)).toList();
      },
    );
  }

  Future<ApiResult<CategoriesByIdDto>> getCategoriesById(String categoryId) async {
    return _handleRequest(
      getRequest('${AppConstants.baseUrl}${AppConstants.categories}/$categoryId'),
          (data) => CategoriesByIdDto.fromJson(data),
    );
  }

  Future<ApiResult<HomeDataResponse>> homeTab() async {
    return _handleRequest(
      getRequest(AppConstants.baseUrl + AppConstants.homeTab),
          (data) => HomeDataResponse.fromJson(data),
    );
  }
}
