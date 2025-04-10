import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/core/resources/constants_manager.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/app_sections/home/categories/data/models/categories_dto.dart';
import 'package:flower_app/features/app_sections/home/occasions/data/models/occasions_dto.dart';
import 'package:flower_app/features/app_sections/home/occasions/data/models/products_dto.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_request_dto.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../features/app_sections/home/categories/data/models/category_by_id_dto.dart';
import '../../features/app_sections/home/categories/domain/entities/product_filter.dart';

import '../../features/app_sections/home/data/model/HomeDataResponse.dart';

@singleton
class ApiManager {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  // TODO : =================== GetRequest ==============
  Future<Response?> getRequest(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (error) {
      print(
        "Get Error: "
        '${error.message}',
      );
      return error.response;
    }
  }

  // TODO : =================== PostRequest ==============

  Future<Response?> postRequest(
    String endpoint,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    try {
      Response response = await dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (error) {
      print(
        "Post Error: "
        '${error.message}',
      );
      return error.response;
    }
  }

  // TODO : =================== PutRequest ==============
  Future<Response?> putRequest(
    String endpoint,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    try {
      Response response = await dio.put(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (error) {
      print(
        "Put Error: "
        '${error.message}',
      );
      return error.response;
    }
  }

  // TODO : =================== PatchRequest ==============
  Future<Response?> patchRequest(
    String endpoint,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    try {
      Response response = await dio.patch(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (error) {
      print(
        "Patch Error: "
        '${error.message}',
      );
      return error.response;
    }
  }

  // TODO : =================== DeleteRequest ==============
  Future<Response?> deleteRequest(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      Response response = await dio.delete(
        endpoint,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (error) {
      print(
        "Delete Error: "
        '${error.message}',
      );
      return error.response;
    }
  }

  //TODO:====================== Function IS Connected =======
  Future<bool> _isConnected() async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.vpn);
  }

  //TODO:====================== Function IS SignUp =======
  Future<ApiResult<SignupResponseDto>> signup(SignupRequestDto signup) async {
    if (!await _isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(errorMessage: 'Please Check your internet'),
      );
    }
    try {
      final response = await postRequest(
        AppConstants.baseUrl + AppConstants.sinUp,
        signup.toJson(),
      );

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return ApiSuccessResult(
            data: SignupResponseDto.fromJson(response.data),
          );
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

  //TODO:====================== Function IS Get Occasion =======
  Future<ApiResult<List<OccasionsDto>>> getOccasions() async {
    if (!await _isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(errorMessage: 'Please Check your internet'),
      );
    }
    try {
      final response = await getRequest(
        AppConstants.baseUrl + AppConstants.occasions,
      );

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<dynamic> occasionsJson = response.data['occasions'] ?? [];
          final List<OccasionsDto> occasionsList =
              occasionsJson.map((json) => OccasionsDto.fromJson(json)).toList();
          return ApiSuccessResult(data: occasionsList);
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

  //TODO:====================== Function IS Get Products By Id=======
  Future<ApiResult<List<ProductDto>>> getProducts(ProductFilter filter) async {
    if (!await _isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(
          errorMessage: 'Please check your internet connection',
        ),
      );
    }

    try {
      final Map<String, dynamic> queryParameters = {};

      if (filter.occasionId != null) {
        queryParameters['occasion'] = filter.occasionId;
      }

      if (filter.categoryId != null) {
        queryParameters['category'] = filter.categoryId;
      }

      final response = await getRequest(
        '${AppConstants.baseUrl}${AppConstants.products}/',
        queryParameters: queryParameters,
      );

      if (response!.statusCode! >= 200 && response.statusCode! < 300) {
        final List<dynamic> productsJson = response.data['products'] ?? [];
        final List<ProductDto> productsList =
        productsJson.map((json) => ProductDto.fromJson(json)).toList();
        return ApiSuccessResult(data: productsList);
      } else {
        return ApiErrorResult(
          failures: ServerError(errorMessage: response.data.toString()),
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


  //TODO:====================== Function IS Get Categories =======
  Future<ApiResult<List<CategoryDto>>> getCategories() async {
    if (!await _isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(errorMessage: 'Please Check your internet'),
      );
    }
    try {
      final response = await getRequest(
        AppConstants.baseUrl + AppConstants.categories,
      );

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<dynamic> result = response.data['categories'] ?? [];
          final List<CategoryDto> categoriesJson =
              result.map((json) => CategoryDto.fromJson(json)).toList();
          return ApiSuccessResult(data: categoriesJson);
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

  //TODO:====================== Function IS Get Categories By Id=======
  Future<ApiResult<CategoriesByIdDto>> getCategoriesById(
    String categoryId,
  ) async {
    if (!await _isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(
          errorMessage: 'Please check your internet connection',
        ),
      );
    }

    try {
      final response = await getRequest(
        '${AppConstants.baseUrl}${AppConstants.categories}/$categoryId',
      );

      if (response!.statusCode! >= 200 && response.statusCode! < 300) {
        final result = CategoriesByIdDto.fromJson(response.data);
        return ApiSuccessResult(data: result);
      } else {
        return ApiErrorResult(
          failures: ServerError(errorMessage: response.data.toString()),
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



//TODO:====================== Function IS home tab =======
  Future<ApiResult<HomeDataResponse>> homeTab() async {
    if (!await _isConnected()) {
      return ApiErrorResult(
          failures: NetworkError(errorMessage: 'Please Check your internet'));
    }
    try {
      final response = await getRequest(AppConstants.baseUrl + AppConstants.homeTab);

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return ApiSuccessResult(
              data: HomeDataResponse.fromJson(response.data));
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
            errorMessage: e.message ?? 'An unexpected error occurred'),
      );
    }
  }
}
