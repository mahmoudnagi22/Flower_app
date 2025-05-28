part of 'best_seller_cubit.dart';

enum Status {
  initial,
  loading,
  loaded,
  error,
}

class BestSellerState extends Equatable {
  final Status status;
  final List<ProductEntity> bestSellerList;
  final String? errorMessage;

  const BestSellerState({
    this.status = Status.initial,
    this.bestSellerList = const [],
    this.errorMessage,
  });

  BestSellerState copyWith({
    Status? status,
    List<ProductEntity>? products,
    String? errorMessage,
  }) {
    return BestSellerState(
      status: status ?? this.status,
      bestSellerList: products ?? this.bestSellerList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, bestSellerList, errorMessage];
}
