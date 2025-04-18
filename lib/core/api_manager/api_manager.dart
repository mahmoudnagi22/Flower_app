import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flower_app/core/resources/constants_manager.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_request_dto.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../features/app_sections/add_to_cart/data/model/AddToCaetResponse.dart';
import '../../features/app_sections/add_to_cart/data/model/Product.dart';
import '../../features/app_sections/add_to_cart/data/model/add_to_cart_parameters.dart';
import '../../features/app_sections/cart/data/models/carts_response_dto.dart';
import '../../features/app_sections/categories/data/models/categories_dto.dart';
import '../../features/app_sections/categories/data/models/category_by_id_dto.dart';
import '../../features/app_sections/categories/domain/entities/product_filter.dart';
import '../../features/app_sections/home/data/model/HomeDataResponse.dart';
import '../../features/app_sections/occasions/data/models/occasions_dto.dart';
import '../../features/app_sections/occasions/data/models/products_dto.dart';
import '../models/api_result.dart';
import '../models/user_model.dart';

@singleton
class ApiManager {
  final Dio _dio;

  ApiManager(this._dio) {
    _dio.options.baseUrl = AppConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.sendTimeout = const Duration(seconds: 10);
    _dio.options.followRedirects = false;
    _dio.options.headers = {"token": UserModel.instance.token,"Authorization": "Bearer ${UserModel.instance.token}"};
  }

  // TODO : =================== GetRequest ==============
  Future<Response?> getRequest(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    dynamic headers,
  }) async {
    try {
      Response response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
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
      Response response = await _dio.post(
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
      Response response = await _dio.put(
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
      Response response = await _dio.patch(
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
      Response response = await _dio.delete(
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
        failures: NetworkError(errorMessage: 'Please Check your internet'),
      );
    }
    try {
      final response = await getRequest(
        AppConstants.baseUrl + AppConstants.homeTab,
      );

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return ApiSuccessResult(
            data: HomeDataResponse.fromJson(response.data),
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
            errorMessage: e.message ?? 'An unexpected error occurred'),
      );
    }
  }



  //TODO:====================== Function IS Add to cart =======
  Future<ApiResult<AddToCartResponse>> addToCart(AddToCartParameters parameters) async {
    if (!await _isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(errorMessage: 'Please Check your internet'),
      );
    }
    try {
      final response = await postRequest(
        AppConstants.baseUrl + AppConstants.addToCart, AddToCartParameters(product: parameters.product),
      );

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return ApiSuccessResult(
            data: AddToCartResponse.fromJson(response.data),
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
  Future<ApiResult<List<CartItemsDto>>> getCartsItem() async {
    if (!await _isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(errorMessage: 'Please Check your internet'),
      );
    }
    try {
      final response = await getRequest(
          AppConstants.addToCart,
        headers: {
          "Authorization": "Bearer ${UserModel.instance.token}"        }



      );

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final cartItemsJson = response.data['cart']['cartItems'] as List;
          final items = cartItemsJson.map((e) => CartItemsDto.fromJson(e)).toList();
          return ApiSuccessResult(data: items);
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
  Future<ApiResult<List<Product>>> updateQuantity(String cartId,int quantity) async {
    if (!await _isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(
            errorMessage: 'Please check your internet connection'),
      );
    }

    try {
      final response = await putRequest(
        '${AppConstants.baseUrl}${AppConstants.addToCart}/$cartId',
        headers: {
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjgwMTA1NzhhOTgzMmQ4MzU5ZTM5ZGQzIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NDQ4OTc0MDF9.5LqsIKrKy5MZ6OKH1lw4xaN-Mpd20GzS8DHUhE_-aG8',
        },
        {
          'quantity': quantity,
        },
      );
      // print('Response Update is: $response');

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<dynamic> result = response.data['product'] ?? [];
          final List<Product> productJson = result.map((json) =>
              Product.fromJson(json)).toList();
          return ApiSuccessResult(data: productJson);
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


//TODO:====================== Function IS Delete Carts Products =======
  Future<ApiResult<List<Product>>> deleteCart(String cartId) async {
    if (!await _isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(
            errorMessage: 'Please check your internet connection'),
      );
    }

    try {
      final response = await deleteRequest(
          '${AppConstants.baseUrl}${AppConstants.addToCart}/$cartId',
          headers: {
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjgwMTA1NzhhOTgzMmQ4MzU5ZTM5ZGQzIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NDQ4OTc0MDF9.5LqsIKrKy5MZ6OKH1lw4xaN-Mpd20GzS8DHUhE_-aG8',
          }
      );
      print('Response Delete is: $response');

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<dynamic> result = response.data['product'] ?? [];
          final List<Product> productJson = result.map((json) =>
              Product.fromJson(json)).toList();
          return ApiSuccessResult(data: productJson);
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
}
@module
abstract class RegisterModule {
  @singleton
  Dio dio() => Dio();
}
