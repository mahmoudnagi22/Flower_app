class CreditOrderRequestEntity {
  final String clientReferenceId;
  final String customerEmail;
  final String city;
  final String street;
  final String phone;
  final String lat;
  final String long;

  const CreditOrderRequestEntity({
    required this.clientReferenceId,
    required this.customerEmail,
    required this.city,
    required this.street,
    required this.phone,
    required this.lat,
    required this.long,
  });
}
