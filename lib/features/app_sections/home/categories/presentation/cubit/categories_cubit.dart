import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/entities/categories_entity.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/use_cases/categories_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/utils/status.dart';

part 'categories_state.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({required this.useCase}) : super(const CategoriesState());

  CategoriesUseCase useCase;

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
      case ApiErrorResult<List<CategoryEntity>>():
        emit(
          state.copyWith(
            categoriesState: Status.error,
            categoriesError: result.failures.errorMessage,
          ),
        );
    }
  }
}
