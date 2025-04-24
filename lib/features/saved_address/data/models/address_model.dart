import 'package:flower_app/features/saved_address/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.id,
    required super.street,
    required super.phone,
    required super.city,
    required super.userName,
    required super.lat,
    required super.long,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'],
      street: json['street'],
      phone: json['phone'],
      userName: json['username'],
      city: json['city'],
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'street': street,
      'phone': phone,
      'username': userName,
      'city': city,
      'lat': lat,
      'long': long,
    };
  }
}
