import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/add_to_cart/data/add_to_cart_data_source/add_to_cart_data_source.dart';
import 'package:flower_app/features/app_sections/add_to_cart/data/model/AddToCaetResponse.dart';
import 'package:flower_app/features/app_sections/add_to_cart/data/model/add_to_cart_parameters.dart';
import 'package:flower_app/features/app_sections/add_to_cart/domain/add_to_cart_repo/add_to_cart_repo.dart';

class AddToCartRepoImpl implements AddToCartRepo{
  AddToCartDataSource addToCartDataSource;
  AddToCartRepoImpl({required this.addToCartDataSource});

  @override
  Future<ApiResult<AddToCartResponse>> addToCart(AddToCartParameters parameters) async{
    var response = await addToCartDataSource.addToCart(parameters);
    return response;
  }
}