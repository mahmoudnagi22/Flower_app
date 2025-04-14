import '../../data/model/BestSeller.dart';
import '../../data/model/Categories.dart';
import '../../data/model/Occasions.dart';
import '../../data/model/Products.dart';

sealed class HomeStates{}

class HomeInitialStates extends HomeStates{}
class HomeLoadingStates extends HomeStates{}
class HomeSuccessStates extends HomeStates{
  final List<Products> products;
  final List<Categories> categories;
  final List<BestSeller> bestSeller;
  final List<Occasions> occasions;
  HomeSuccessStates({
    required this.products,
    required this.categories,
    required this.bestSeller,
    required this.occasions,
  });
}
class HomeErrorStates extends HomeStates{
  String massage;
  HomeErrorStates({required this.massage});
}