import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/resources/assets_manager.dart';
import 'package:flower_app/features/app_sections/home/best_seller/presentation/cubit/best_seller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellerScreen extends StatefulWidget {
  const BestSellerScreen({super.key});

  @override
  State<BestSellerScreen> createState() => _BestSellerScreenState();
}

class _BestSellerScreenState extends State<BestSellerScreen> {
  late BestSellerCubit bestSellerCubit;

  @override
  void initState() {
    super.initState();
    bestSellerCubit = getIt<BestSellerCubit>();
    bestSellerCubit.getBestSellerProduct(); // يتم الاستدعاء مرة واحدة فقط عند بدء الشاشة
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bestSellerCubit,
      child: Scaffold(
        appBar: AppBar(title: const Text("Best Seller")),
        body: BlocBuilder<BestSellerCubit, BestSellerState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == Status.success) {
              final bestSellers = state.bestSellers;

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: bestSellers?.length ?? 0,
                itemBuilder: (context, index) {
                  final product = bestSellers![index];

                  return ProductCard(
                    title: product.title ?? 'عنوان غير متوفر',
                    price: (product.price as double?) ?? 600.0,
                    oldPrice: (product.price as double?) ?? 800.0,
                    discount: product.discount ?? 20,
                    imageUrl: (product.images as String?) ?? ImageAssets.image,
                  );
                },
              );
            } else if (state.status == Status.failure) {
              return Center(
                child: Text("حدث خطأ: ${state.errorMessage.toString()}"),
              );
            } else {
              return const Center(child: Text("معلومات غير متاحة"));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            bestSellerCubit.getBestSellerProduct();
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final double oldPrice;
  final int discount;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المنتج
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 80),
            ),
          ),

          // اسم المنتج
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),

          // السعر والخصم
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  "EGP $price",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 6),
                Text(
                  "EGP $oldPrice",
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 6),
                Text("$discount%", style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),

          const Spacer(),

          // زر "Add to cart"
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                minimumSize: const Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
              label: const Text("Add to cart"),
            ),
          ),
        ],
      ),
    );
  }
}
