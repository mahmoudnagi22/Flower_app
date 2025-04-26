import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/app_sections/search/domain/entities/search_entity.dart';
import 'package:flower_app/features/app_sections/search/domain/use_cases/get_products_by_search.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/utils/status.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.useCase}) : super(SearchState());

  GetProductsBySearch useCase;

  void fetchProducts(String keyWord) async {

    emit(state.copyWith(searchState: Status.loading));

    ApiResult<SearchEntity> result = await useCase.call(keyWord);

    switch (result) {
      case ApiSuccessResult<SearchEntity>():
        emit(state.copyWith(searchState: Status.success,searchList: result.data));
      case ApiErrorResult<SearchEntity>():
        emit(state.copyWith(searchError: result.failures.errorMessage),);

    }

  }
}
