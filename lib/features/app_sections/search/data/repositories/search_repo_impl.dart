import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/app_sections/search/data/data_sources/search_data_source.dart';
import 'package:flower_app/features/app_sections/search/domain/entities/search_entity.dart';
import 'package:flower_app/features/app_sections/search/domain/repositories/search_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SearchRepo )
class SearchRepoImpl implements SearchRepo {
  SearchDataSource dataSource;
  SearchRepoImpl({required this.dataSource});
  @override
  Future<ApiResult<SearchEntity>> fetchProducts(String keyWord) async{
    return await dataSource.fetchProducts(keyWord);
  }

}