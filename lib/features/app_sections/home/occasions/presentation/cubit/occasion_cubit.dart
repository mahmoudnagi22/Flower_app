import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/core/utils/status.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/entities/occasion_by_id_entity.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/use_cases/occasion_by_id_entity.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/use_cases/occasion_use_case.dart';
import 'package:injectable/injectable.dart';

part 'occasion_state.dart';

@injectable
class OccasionCubit extends Cubit<OccasionState> {
  OccasionCubit({
    required this.occasionUseCase,
    required this.occasionByIdUseCase,
  }) : super(const OccasionState());

  OccasionUseCase occasionUseCase;
  OccasionByIdUseCase occasionByIdUseCase;

  void getOccasions() async {
    emit(state.copyWith(occasionState: Status.loading));
    ApiResult<List<OccasionsEntity>> result = await occasionUseCase.call();

    switch (result) {
      case ApiSuccessResult<List<OccasionsEntity>>():
        emit(
          state.copyWith(
            occasionList: result.data,
            occasionState: Status.success,
          ),
        );
        if (result.data.isNotEmpty) {
          getOccasionById(result.data.first.id!);
        }
        break;
      case ApiErrorResult<List<OccasionsEntity>>():
        emit(
          state.copyWith(
            occasionError: result.failures.errorMessage,
            occasionState: Status.error,
          ),
        );
    }
  }

  void getOccasionById(String occasionId) async {
    emit(state.copyWith(occasionByIdState: Status.loading));
    ApiResult<OccasionsByIdEntity> result = await occasionByIdUseCase.call(
      occasionId,
    );

    switch (result) {
      case ApiSuccessResult<OccasionsByIdEntity>():
        emit(
          state.copyWith(
            occasionByIdState: Status.success,
            occasionById: result.data,
          ),
        );
      case ApiErrorResult<OccasionsByIdEntity>():
        emit(
          state.copyWith(
            occasionByIdError: result.failures.errorMessage,
            occasionByIdState: Status.error,
          ),
        );
    }
  }
}
