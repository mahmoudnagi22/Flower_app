import 'package:dots_indicator/dots_indicator.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/l10n/app_localizations.dart';
import 'package:flower_app/core/models/user_model.dart';
import 'package:flower_app/core/resources/assets_manager.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/core/utils/dialog_utils.dart';
import 'package:flower_app/features/app_sections/add_to_cart/data/model/add_to_cart_parameters.dart';
import 'package:flower_app/features/app_sections/add_to_cart/presentation/cubit/add_to_cart_cubit.dart';
import 'package:flower_app/features/app_sections/add_to_cart/presentation/cubit/add_to_cart_state.dart';
import 'package:flower_app/features/app_sections/occasions/domain/entities/products_entity.dart';
import 'package:flower_app/features/app_sections/product_details/presentation/widgets/custom_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({required this.product, super.key});
  final ProductEntity product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  PageController? pageController;
  AddToCartCubit addToCartCubit = getIt<AddToCartCubit>();
  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      body: BlocProvider(
        create: (context) => addToCartCubit,
        child: BlocListener<AddToCartCubit, AddToCartState>(
          listener: (context, state) {
            if (state is AddToCartLoadingState) {
              DialogUtils.showLoading(context, lang.login);
            }
            if (state is AddToCartSuccessState) {
              DialogUtils.hideLoading(context);
              DialogUtils.showSuccess(
                context,
                "✅ Product has been added to cart",
              );
            } else if (state is AddToCartErrorState) {
              DialogUtils.hideLoading(context);
              DialogUtils.showError(context, state.massage);
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CustomPageView(
                        images: widget.product.images!,
                        pageController: pageController,
                      ),
                      Positioned(
                        bottom: 8,
                        left: 156,
                        child: DotsIndicator(
                          dotsCount: widget.product.images!.length,
                          position:
                              pageController!.hasClients
                                  ? pageController!.page ?? 0.0
                                  : 0.0,
                          decorator: DotsDecorator(
                            activeColor: ColorManager.appColor,
                            color: ColorManager.white70,
                            size: const Size(10, 10),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        left:
                            Directionality.of(context) == TextDirection.ltr
                                ? 16
                                : null,
                        right:
                            Directionality.of(context) == TextDirection.rtl
                                ? 16
                                : null,

                        child: IconButton(
                          iconSize: 30,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: ColorManager.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${lang!.currency} ${widget.product.price}',
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                height: 1.0, // 100% line-height = height of 1.0
                                letterSpacing: 0,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${lang.status}:',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                height: 1.0,
                                letterSpacing: 0,
                              ),
                            ),

                            Text(
                              widget.product.quantity != 0
                                  ? '${lang.inStock}'
                                  : '${lang.outStock}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.0,
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${lang.tax}',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            height: 1.0,
                            letterSpacing: 0,
                            color: ColorManager.gray,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.product.title!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '${lang.description}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.product.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: ColorManager.appColor,
            ),
            onPressed: () {
              UserModel userModel = UserModel.instance;
              if (userModel.token == null) {
                showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return AlertDialog(
                      content: Text('${lang.haveAccount}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("${lang.cancel}"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.loginRoute,
                            );
                          },
                          child: Text("${lang.login}"),
                        ),
                      ],
                    );
                  },
                );
              } else {
                final productId = widget.product.id!;
                addToCartCubit.addToCart(
                  AddToCartParameters(product: productId),
                );
              }
            },
            child: Text(
              '${lang.addToCart}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
