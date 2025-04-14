import 'package:equatable/equatable.dart';
import 'package:flower_app/features/app_sections/home/best_seller/data/model/best_seller_model.dart';

class BestSellerProductEntity extends Equatable {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final int price;
  final int priceAfterDiscount;
  final int quantity;
  final String category;
  final String occasion;
  final String createdAt;
  final String updatedAt;
  final int discount;
  final int sold;
  final double rateAvg;
  final int rateCount;

  const BestSellerProductEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.createdAt,
    required this.updatedAt,
    required this.discount,
    required this.sold,
    required this.rateAvg,
    required this.rateCount,
  });

  factory BestSellerProductEntity.fromModel(ProductModel model) {
    return BestSellerProductEntity(
      id: model.id,
      title: model.title,
      slug: model.slug,
      description: model.description,
      imgCover: model.imgCover,
      images: model.images,
      price: model.price,
      priceAfterDiscount: model.priceAfterDiscount,
      quantity: model.quantity,
      category: model.category,
      occasion: model.occasion,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      discount: model.discount,
      sold: model.sold,
      rateAvg: model.rateAvg,
      rateCount: model.rateCount,
    );
  }

  @override
  List<Object> get props => [
    id,
    title,
    slug,
    description,
    imgCover,
    images,
    price,
    priceAfterDiscount,
    quantity,
    category,
    occasion,
    createdAt,
    updatedAt,
    discount,
    sold,
    rateAvg,
    rateCount,
  ];
}
