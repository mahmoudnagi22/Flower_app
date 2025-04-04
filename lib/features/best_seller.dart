import 'package:flower_app/core/resources/assets_manager.dart';
import 'package:flower_app/core/widget/shared_ui_widget.dart';
import 'package:flutter/material.dart';

class BestSeller extends StatelessWidget {
  const BestSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomSliverScreen(
      isSearch: true,
      appBarTitle: "Best Seller",
      appBarSubTitle: "Bloom with our exquisite best sellers",
      image: ImageAssets.image,
      title: 'Red roses',
      price: 600,
      oldPrice: 800,
      discount: 20, multipleChoice: true,

      categories: ["All", "Roses", "Tulips", "Bouquets", "Gifts","Vases","Boxes"],
    );
  }
}
