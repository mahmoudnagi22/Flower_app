import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/app_sections/add_to_cart/data/model/AddToCaetResponse.dart';
import 'package:flower_app/features/app_sections/add_to_cart/data/model/add_to_cart_parameters.dart';

abstract class AddToCartDataSource{
  Future<ApiResult<AddToCartResponse>>addToCart(AddToCartParameters parameters);
}