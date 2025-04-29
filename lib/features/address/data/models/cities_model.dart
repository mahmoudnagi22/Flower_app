class CitiesModel {
  String id;
  String cityNameAr;
  String cityNameEn;

  CitiesModel({
    required this.id,
    required this.cityNameAr,
    required this.cityNameEn,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> json) {
    return CitiesModel(
      id: json['id'],
      cityNameAr: json['governorate_name_ar'],
      cityNameEn: json['governorate_name_en'],
    );
  }
}
