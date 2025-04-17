part of 'cart_cubit.dart';

class CartState extends Equatable {
  final Status cartStatus;
  final String? updateError;
  final List<CartItemsEntity>? cartsList;
  final List<ProductEntity>? updateList;
  final List<ProductEntity>? deleteItem;

  @override
  // TODO: implement props
  List<Object?> get props => [cartStatus,updateError,cartsList,deleteItem,updateList];

  const CartState({
    this.cartStatus = Status.initial,
    this.updateError,
    this.cartsList,
    this.updateList,
    this.deleteItem
  });

  CartState copyWith({
    Status? cartStatus,
    String? updateError,
    List<CartItemsEntity>? cartsList,
    List<ProductEntity>? updateList,
    List<ProductEntity>? deleteItem,
  }) {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
      updateError: updateError ?? this.updateError,
      cartsList: cartsList ?? this.cartsList,
      updateList: updateList ?? this.updateList,
      deleteItem: deleteItem ?? this.deleteItem,
    );
  }

}


