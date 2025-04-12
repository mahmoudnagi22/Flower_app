part of 'categories_cubit.dart';

class CategoriesState extends Equatable {
  final Status categoriesState;
  final Status productsState;
  final String? categoriesError;
  final List<CategoryEntity>? categoryList;
  final List<ProductEntity>? products;


  const CategoriesState({
    this.categoriesState = Status.initial,
    this.productsState = Status.initial,
    this.categoriesError,
    this.categoryList,
    this.products
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    categoriesState,
    categoriesError,
    categoryList,
    products,
  ];

  CategoriesState copyWith({
    Status? categoriesState,
    Status? productsState,
    String? categoriesError,
    List<CategoryEntity>? categoryList,
    List<ProductEntity>? products,
  }) {
    return CategoriesState(
      categoriesState: categoriesState ?? this.categoriesState,
      productsState: productsState ?? this.productsState,
      categoriesError: categoriesError ?? this.categoriesError,
      categoryList: categoryList ?? this.categoryList,
      products: products ?? this.products,
    );
  }

}
