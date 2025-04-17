class AddToCartParameters {
  final String product;
  final num quantity = 1;
  AddToCartParameters({required this.product });

  Map<String,dynamic> toJson(){
    return {
      "product":product,
      "quantity":quantity
    };
  }
}


