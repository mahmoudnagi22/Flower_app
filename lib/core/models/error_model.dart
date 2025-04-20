class ErrorModel {
  ErrorModel({this.message});

  ErrorModel.fromJson(dynamic json) {
    message = json['error'];
  }

   String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = message;

    return map;
  }
}
