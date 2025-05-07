import 'package:flower_app/core/resources/constants_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_source/data_source.dart';
@Injectable(as : LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  late SharedPreferences sharedPreferences;

  @override
  Future<String?> getLocale() async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      return sharedPreferences.getString(AppConstants.localKey);
    } catch (ex) {
      return null;
    }
  }

  @override
  Future<void> setLocale(String lang) async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      await sharedPreferences.setString(AppConstants.localKey, lang);
    } catch (ex) {
      return;
    }
  }
}
