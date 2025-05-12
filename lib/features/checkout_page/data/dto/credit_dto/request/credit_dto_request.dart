import 'package:flower_app/features/checkout_page/domain/entity/credit_order/request/credit_order_request_entity.dart';

class CreditOrderRequestDto extends CreditOrderRequestEntity {
  const CreditOrderRequestDto({
    required String clientReferenceId,
    required String customerEmail,
    required String city,
    required String street,
    required String phone,
    required String lat,
    required String long,
  }) : super(
    clientReferenceId: clientReferenceId,
    customerEmail: customerEmail,
    city: city,
    street: street,
    phone: phone,
    lat: lat,
    long: long,
  );

  factory CreditOrderRequestDto.fromJson(Map<String, dynamic> json) {
    return CreditOrderRequestDto(
      clientReferenceId: json['clientReferenceId'],
      customerEmail: json['customerEmail'],
      city: json['city'],
      street: json['street'],
      phone: json['phone'],
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientReferenceId': clientReferenceId,
      'customerEmail': customerEmail,
      'city': city,
      'street': street,
      'phone': phone,
      'lat': lat,
      'long': long,
    };
  }

  // Convert DTO to Entity
  static CreditOrderRequestDto fromEntity(CreditOrderRequestEntity entity) {
    return CreditOrderRequestDto(
      clientReferenceId: entity.clientReferenceId,
      customerEmail: entity.customerEmail,
      city: entity.city,
      street: entity.street,
      phone: entity.phone,
      lat: entity.lat,
      long: entity.long,
    );
  }

}
