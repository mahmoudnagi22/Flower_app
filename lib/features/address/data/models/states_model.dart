class StatesModel {
 final String id;
 final String governorateId;

 final String stateNameAr;
 final  String stateNameEn;

  StatesModel({required this.id,required this.governorateId,required this.stateNameAr,required this.stateNameEn});

  factory StatesModel.fromJson(Map<String, dynamic> json) {
    return StatesModel(
      id: json['id'],
      governorateId: json['governorate_id'],
      stateNameAr: json['city_name_ar'],
      stateNameEn: json['city_name_en'],
    );
  }

}