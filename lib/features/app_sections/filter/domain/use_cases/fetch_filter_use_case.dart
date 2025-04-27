
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/app_sections/filter/domain/entities/filter_entity.dart';
import 'package:flower_app/features/app_sections/filter/domain/repositories/filter_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class FitchFilterUseCase {
  FilterRepo repo;
  FitchFilterUseCase({required this.repo});


  Future<ApiResult<FilterEntity>> call(String filter)async{
  return await repo.fetchProductsByFilter(filter);
  }
}