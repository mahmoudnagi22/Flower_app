import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/entities/categories_entity.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/entities/category_by_id_entity.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/entities/product_filter.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/use_cases/get_categories_by_id_use_case.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/utils/status.dart';
import '../../../occasions/domain/entities/products_entity.dart';
import '../../../occasions/domain/use_cases/product_use_case.dart';

part 'categories_state.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({required this.useCase, required this.productsUseCase})
    : super(const CategoriesState());

  GetCategoriesUseCase useCase;
  ProductsUseCase productsUseCase;

  void getCategories() async {
    emit(state.copyWith(categoriesState: Status.loading));

    ApiResult<List<CategoryEntity>> result = await useCase.call();

    switch (result) {
      case ApiSuccessResult<List<CategoryEntity>>():
        emit(
          state.copyWith(
            categoriesState: Status.success,
            categoryList: result.data,
          ),
        );

        if (result.data.isNotEmpty) {
          getProducts(ProductFilter(categoryId: result.data.first.id));
        }
      case ApiErrorResult<List<CategoryEntity>>():
        emit(
          state.copyWith(
            categoriesState: Status.error,
            categoriesError: result.failures.errorMessage,
          ),
        );
    }
  }

  Future<void> getProducts(ProductFilter filter) async {
    emit(state.copyWith(productsState: Status.loading));

    ApiResult<List<ProductEntity>> result = await productsUseCase.call(filter);

    switch (result) {
      case ApiSuccessResult<List<ProductEntity>>():
        emit(
          state.copyWith(productsState: Status.success, products: result.data),
        );
      case ApiErrorResult<List<ProductEntity>>():
        emit(
          state.copyWith(
            productsState: Status.error,
            categoriesError: result.failures.errorMessage,
          ),
        );
    }
  }
}
