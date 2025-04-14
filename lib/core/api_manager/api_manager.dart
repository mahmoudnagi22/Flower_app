import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/core/resources/constants_manager.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/app_sections/home/best_seller/data/model/best_seller_model.dart';
import 'package:flower_app/features/app_sections/home/categories/data/models/categories_dto.dart';
import 'package:flower_app/features/app_sections/home/categories/data/models/category_by_id_dto.dart';
import 'package:flower_app/features/app_sections/home/occasions/data/models/occasions_by_id_dto.dart';
import 'package:flower_app/features/app_sections/home/occasions/data/models/occasions_dto.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_request_dto.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_response_dto.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiManager {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  // Centralized method for handling request responses
  Future<ApiResult<T>> _handleRequest<T>(
    Future<Response?> request,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    if (!await _isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(
          errorMessage: 'Please check your internet connection',
        ),
      );
    }

    try {
      final response = await request;

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return ApiSuccessResult(data: fromJson(response.data));
        } else {
          return ApiErrorResult(
            failures: ServerError(errorMessage: response.data.toString()),
          );
        }
      } else {
        return ApiErrorResult(
          failures: ServerError(errorMessage: 'No response from server'),
        );
      }
    } on DioException catch (e) {
      return ApiErrorResult(
        failures: ServerError(
          errorMessage: e.message ?? 'An unexpected error occurred',
        ),
      );
    }
  }
  // TODO : getOccasions = > Method

  Future<ApiResult<List<OccasionsDto>>> getOccasions() async {
    return _handleRequest<List<OccasionsDto>>(
      getRequest(AppConstants.baseUrl + AppConstants.occasions),
      (data) {
        final List<dynamic> occasionsJson = data['occasions'] ?? [];
        return occasionsJson
            .map((json) => OccasionsDto.fromJson(json))
            .toList();
      },
    );
  }

  // TODO : getBestSellerProduct = > Method
  Future<ApiResult<List<ProductModel>>> getBestSellers() async {
    return _handleRequest<List<ProductModel>>(
      getRequest(AppConstants.baseUrl + AppConstants.bestSeller),
      (data) {
        final List<dynamic> bestSellerJson = data['bestSeller'] ?? [];
        return bestSellerJson
            .map((productJson) => ProductModel.fromJson(productJson))
            .toList();
      },
    );
  }

  //TODO: Method to check internet connectivity
  Future<bool> _isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.vpn;
  }

  // TODO : signup = > Method
  Future<ApiResult<SignupResponseDto>> signup(SignupRequestDto signup) async {
    return _handleRequest<SignupResponseDto>(
      postRequest(AppConstants.baseUrl + AppConstants.sinUp, signup.toJson()),
      (data) => SignupResponseDto.fromJson(data),
    );
  }

  //TODO: Common GET request method
  Future<Response?> getRequest(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(endpoint, queryParameters: queryParameters);
    } on DioException catch (error) {
      print("Get Error: ${error.message}");
      return error.response;
    }
  }

  //TODO: Simplified POST request method
  Future<Response?> postRequest(
    String endpoint,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    try {
      return await dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (error) {
      print("Post Error: ${error.message}");
      return error.response;
    }
  }

  // TODO : getOccasionById = > Method
  Future<ApiResult<OccasionsByIdDto>> getOccasionById(String occasionId) async {
    return _handleRequest<OccasionsByIdDto>(
      getRequest(
        '${AppConstants.baseUrl}${AppConstants.occasions}/$occasionId',
      ),
      (data) => OccasionsByIdDto.fromJson(data),
    );
  }
  // TODO : getCategories = > Method

  Future<ApiResult<List<CategoryDto>>> getCategories() async {
    return _handleRequest<List<CategoryDto>>(
      getRequest(AppConstants.baseUrl + AppConstants.categories),
      (data) {
        final List<dynamic> categoriesJson = data['categories'] ?? [];
        return categoriesJson
            .map((json) => CategoryDto.fromJson(json))
            .toList();
      },
    );
  }
  // TODO : getCategoriesById = > Method

  Future<ApiResult<CategoriesByIdDto>> getCategoriesById(
    String categoryId,
  ) async {
    return _handleRequest<CategoriesByIdDto>(
      getRequest(
        '${AppConstants.baseUrl}${AppConstants.categories}/$categoryId',
      ),
      (data) => CategoriesByIdDto.fromJson(data),
    );
  }
}
