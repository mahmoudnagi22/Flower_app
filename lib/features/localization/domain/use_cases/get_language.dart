import 'package:flower_app/features/localization/data/data_source/data_source.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetLanguageUseCase {
  LocalDataSource localDataSource;

  GetLanguageUseCase(this.localDataSource);

  Future<String?> call() async {
    return await localDataSource.getLocale() ;
  }
}


