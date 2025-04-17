abstract class LocalDataSource {
  Future<String?> getLocale();
  Future<void> setLocale(String lang);

}