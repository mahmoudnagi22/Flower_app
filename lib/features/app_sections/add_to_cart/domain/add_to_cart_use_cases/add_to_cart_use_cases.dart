
import 'package:flower_app/features/app_sections/add_to_cart/data/model/AddToCaetResponse.dart';
import 'package:flower_app/features/app_sections/add_to_cart/data/model/add_to_cart_parameters.dart';
import 'package:flower_app/features/app_sections/add_to_cart/domain/add_to_cart_repo/add_to_cart_repo.dart';

import '../../../../../core/api_manager/api_result.dart';

class AddToCartUseCases{
  AddToCartRepo addToCartRepo;
  AddToCartUseCases({required this.addToCartRepo});

  Future<ApiResult<AddToCartResponse>> call(AddToCartParameters parameters) => addToCartRepo.addToCart(parameters);
}