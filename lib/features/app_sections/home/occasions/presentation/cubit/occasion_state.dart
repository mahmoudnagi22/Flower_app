part of 'occasion_cubit.dart';

class OccasionState extends Equatable {
  final Status occasionState;
  final Status productsState;
  final String? occasionError;
  final List<OccasionsEntity>? occasionList;
  final List<ProductEntity>? products;

  const OccasionState({
    this.occasionState = Status.initial,
    this.productsState = Status.initial,
    this.occasionError,

    this.occasionList,
    this.products,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    occasionState,
    productsState,
    occasionError,
    occasionList,
    products,
  ];

  OccasionState copyWith({
    Status? occasionState,
    Status? productsState,
    String? occasionError,
    List<OccasionsEntity>? occasionList,
    List<ProductEntity>? products,
  }) {
    return OccasionState(
      occasionState: occasionState ?? this.occasionState,
      productsState: productsState ?? this.productsState,
      occasionError: occasionError ?? this.occasionError,
      occasionList: occasionList ?? this.occasionList,
      products: products ?? this.products,
    );
  }
}
