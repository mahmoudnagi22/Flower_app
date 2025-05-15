class ShippingAddress {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  ShippingAddress({
    required this.city,
    required this.lat,
    required this.long,
    required this.phone,
    required this.street,
  });
  Map<String,dynamic>toJson(){
    return{
      "street": street,
        "phone": phone,
        "city": city,
        "lat": lat,
        "long": long,
    };
  }
}
class RequestShippingBody {
  final ShippingAddress shippingAddress;

  RequestShippingBody({required this.shippingAddress});

  Map<String, dynamic> toJson() {
    return {
      'shippingAddress': shippingAddress.toJson(),
    };
  }
}