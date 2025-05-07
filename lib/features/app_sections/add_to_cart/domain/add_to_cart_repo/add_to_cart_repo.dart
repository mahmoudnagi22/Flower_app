import '../../../../../core/models/api_result.dart';
import '../../data/model/AddToCaetResponse.dart';
import '../../data/model/add_to_cart_parameters.dart';

abstract class AddToCartRepo{
  Future<ApiResult<AddToCartResponse>>addToCart(AddToCartParameters parameters);
}