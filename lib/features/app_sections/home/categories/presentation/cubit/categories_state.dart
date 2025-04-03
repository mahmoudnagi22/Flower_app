part of 'categories_cubit.dart';

class CategoriesState extends Equatable {
  final Status categoriesState;
  final String? categoriesError;
  final List<CategoryEntity>? categoryList;

  const CategoriesState({
    this.categoriesState = Status.initial,
    this.categoriesError,
    this.categoryList,
  });

  CategoriesState copyWith({
    Status? categoriesState,
    String? categoriesError,
    List<CategoryEntity>? categoryList,
  }) {
    return CategoriesState(
      categoriesState: categoriesState ?? this.categoriesState,
      categoriesError: categoriesError ?? this.categoriesError,
      categoryList: categoryList ?? this.categoryList,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [categoriesState, categoriesError, categoryList];
}
