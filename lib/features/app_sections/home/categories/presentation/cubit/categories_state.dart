part of 'categories_cubit.dart';

class CategoriesState extends Equatable {
  final Status categoriesState;
  final Status categoriesByIdState;
  final String? categoriesError;
  final List<CategoryEntity>? categoryList;
  final CategoriesByIdEntity? categoryById;

  const CategoriesState({
    this.categoriesState = Status.initial,
    this.categoriesByIdState = Status.initial,
    this.categoriesError,
    this.categoryList,
    this.categoryById,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    categoriesState,
    categoriesError,
    categoryList,
    categoryById,
  ];

  CategoriesState copyWith({
    Status? categoriesState,
    Status? categoriesByIdState,
    String? categoriesError,
    List<CategoryEntity>? categoryList,
    CategoriesByIdEntity? categoryById,
  }) {
    return CategoriesState(
      categoriesState: categoriesState ?? this.categoriesState,
      categoriesByIdState: categoriesByIdState ?? this.categoriesByIdState,
      categoriesError: categoriesError ?? this.categoriesError,
      categoryList: categoryList ?? this.categoryList,
      categoryById: categoryById ?? this.categoryById,
    );
  }
}
