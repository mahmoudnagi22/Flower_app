part of 'cart_cubit.dart';

class CartState extends Equatable {
  final Status cartStatus;
  final String? updateError;
  final List<CartItemsEntity>? cartsList;

  @override
  // TODO: implement props
  List<Object?> get props => [cartStatus,updateError,cartsList];

  const CartState({
    this.cartStatus = Status.initial,
    this.updateError,
    this.cartsList,
  });

  CartState copyWith({
    Status? cartStatus,
    String? updateError,
    List<CartItemsEntity>? cartsList,
  }) {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
      updateError: updateError ?? this.updateError,
      cartsList: cartsList ?? this.cartsList,
    );
  }
}


