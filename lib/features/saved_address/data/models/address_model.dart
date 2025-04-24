import 'package:flower_app/features/saved_address/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.id,
    required super.address,
    required super.phoneNumber,
    required super.city,
    required super.recipientName,
    required super.area,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      recipientName: json['recipientName'],
      city: json['city'],
      area: json['area'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'address': address,
      'phoneNumber': phoneNumber,
      'recipientName': recipientName,
      'city': city,
      'area': area,
    };
  }
}
