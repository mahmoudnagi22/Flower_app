class Address {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String username;
  final String? id;

  Address({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
     this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String,
      phone: json['phone'] as String,
      city: json['city'] as String,
      lat: json['lat'] as String,
      long: json['long'] as String,
      username: json['username'] as String,
      id: json['_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'phone': phone,
      'city': city,
      'lat': lat,
      'long': long,
      'username': username,
    };
  }
}
