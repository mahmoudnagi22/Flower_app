import 'Products.dart';
import 'Categories.dart';
import 'BestSeller.dart';
import 'Occasions.dart';

class HomeDataResponse {
  HomeDataResponse({
    required this.message,
    required this.products,
    required this.categories,
    required this.bestSeller,
    required this.occasions,
  });

  String message;
  List<Products> products;
  List<Categories> categories;
  List<BestSeller> bestSeller;
  List<Occasions> occasions;

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) {
    return HomeDataResponse(
      message: json['message'] ?? '',
      products: (json['products'] as List)
          .map((e) => Products.fromJson(e))
          .toList(),
      categories: (json['categories'] as List)
          .map((e) => Categories.fromJson(e))
          .toList(),
      bestSeller: (json['bestSeller'] as List)
          .map((e) => BestSeller.fromJson(e))
          .toList(),
      occasions: (json['occasions'] as List)
          .map((e) => Occasions.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'products': products.map((e) => e.toJson()).toList(),
      'categories': categories.map((e) => e.toJson()).toList(),
      'bestSeller': bestSeller.map((e) => e.toJson()).toList(),
      'occasions': occasions.map((e) => e.toJson()).toList(),
    };
  }
}
