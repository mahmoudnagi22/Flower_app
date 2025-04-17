import 'package:flower_app/core/resources/assets_manager.dart';
import 'package:flower_app/features/localization/data/data_source/data_source.dart';
import 'package:injectable/injectable.dart';
@injectable
class SetLanguageUseCase {
  LocalDataSource localDataSource;

  SetLanguageUseCase(this.localDataSource);

  Future<void> call(String lang) async {
    return await localDataSource.setLocale(lang);
  }
}
