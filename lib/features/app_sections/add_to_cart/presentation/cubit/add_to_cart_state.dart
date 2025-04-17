import '../../data/model/AddToCaetResponse.dart';

abstract class AddToCartState{}


class AddToCartInitState extends AddToCartState{}
class AddToCartLoadingState extends AddToCartState{}
class AddToCartSuccessState extends AddToCartState{
  AddToCartResponse addToCartResponse;
  AddToCartSuccessState({required this.addToCartResponse});
}
class AddToCartErrorState extends AddToCartState{
  String massage;
  AddToCartErrorState({required this.massage});
}