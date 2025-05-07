import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/app_sections/search/domain/entities/search_entity.dart';
import 'package:flower_app/features/app_sections/search/domain/repositories/search_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsBySearch {
  SearchRepo repo;

  GetProductsBySearch({required this.repo});

  Future<ApiResult<SearchEntity>> call(String keyWord) async {
    return  repo.fetchProducts(keyWord);
  }
}
