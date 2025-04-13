part of 'cart_cubit.dart';

class CartState extends Equatable {
  final Status updateStatus;
  final String? updateError;
  final List<CartItemsEntity>? updateList;

  @override
  // TODO: implement props
  List<Object?> get props => [updateStatus,updateError,updateList];

  const CartState({
    this.updateStatus = Status.initial,
    this.updateError,
    this.updateList,
  });

  CartState copyWith({
    Status? updateStatus,
    String? updateError,
    List<CartItemsEntity>? updateList,
  }) {
    return CartState(
      updateStatus: updateStatus ?? this.updateStatus,
      updateError: updateError ?? this.updateError,
      updateList: updateList ?? this.updateList,
    );
  }
}


