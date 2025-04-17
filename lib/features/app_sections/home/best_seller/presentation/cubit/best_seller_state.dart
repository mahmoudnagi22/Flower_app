part of 'best_seller_cubit.dart';

enum Status { loading, success, failure }

// ignore: must_be_immutable
class BestSellerState extends Equatable {
  Status status;
  List<BestSellerProductEntity>? bestSellers;
  String? errorMessage;
  BestSellerState({required this.status, this.bestSellers, this.errorMessage});

  BestSellerState copyWith({
    Status? status,
    List<BestSellerProductEntity>? bestSellers,
    String? errorMessage,
  }) {
    return BestSellerState(
      status: status ?? this.status,
      bestSellers: bestSellers ?? this.bestSellers,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, bestSellers, errorMessage];
}
