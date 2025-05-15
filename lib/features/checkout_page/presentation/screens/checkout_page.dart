import 'dart:developer';

import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_button.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/shipping_address.dart';
import 'package:flower_app/features/checkout_page/presentation/widgets/adderess_widget.dart';
import 'package:flower_app/features/checkout_page/presentation/widgets/payment_card_widget.dart';
import 'package:flower_app/features/app_sections/cart/presentation/cubit/cart_cubit.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/order_entity_request.dart';
import 'package:flower_app/features/checkout_page/domain/entity/credit_order/request/credit_order_request_entity.dart';
import 'package:flower_app/features/checkout_page/presentation/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout_page/presentation/cubit/checkout_state.dart';
import 'package:flower_app/features/checkout_page/presentation/cubit/payment_cubit.dart';
import 'package:flower_app/features/checkout_page/presentation/widgets/switch_botton_widget.dart';
import 'package:flower_app/features/saved_address/data/models/address_model.dart';
import 'package:flower_app/features/saved_address/presentation/view_model/address_cubit.dart';
import 'package:flower_app/features/saved_address/presentation/view_model/address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../address/presentation/cubits/address_cubit/address_cubit.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<PaymentMethodCubit>()),
        BlocProvider(create: (_) => getIt<CheckoutCubit>()),
        BlocProvider(create: (_) => getIt<CartCubit>()),
        BlocProvider(create: (_) => getIt<SavedAddressCubit>()..getAddresses()),
      ],
      child: const CheckoutContent(),
    );
  }
}

class CheckoutContent extends StatefulWidget {
  const CheckoutContent({super.key});

  @override
  State<CheckoutContent> createState() => _CheckoutContentState();
}

class _CheckoutContentState extends State<CheckoutContent> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocBuilder<PaymentMethodCubit, String>(
                builder: (context, selectedMethod) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery time",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Schedule",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: ColorManager.appColor,
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Instant, ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: " Arrive by 03 Sep 2024, 11:00 AM ",
                              style: TextStyle(
                                color: ColorManager.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Delivery address',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BlocBuilder<SavedAddressCubit, AddressState>(
                        builder: (context, state) {
                          if (state is AddressLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is AddressError) {
                            return Center(child: Text(state.message));
                          } else if (state is AddressSuccess) {
                            return AdderessWidget(
                              addresses: state.addresses,
                              selected: (val) {
                                context.read<CheckoutCubit>().selectAddress(
                                  val,
                                );
                              },
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      const Text(
                        'Payment Method:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      PaymentCard(
                        label: 'Cash on delivery',
                        groupValue: selectedMethod,
                        onChanged:
                            (val) => context
                                .read<PaymentMethodCubit>()
                                .selectMethod(val),
                      ),
                      PaymentCard(
                        label: 'Credit card',
                        groupValue: selectedMethod,
                        onChanged:
                            (val) => context
                                .read<PaymentMethodCubit>()
                                .selectMethod(val),
                      ),
                      const SizedBox(height: 16),
                      if (selectedMethod == 'Credit card')
                        SwitchDialogExample(),
                      const SizedBox(height: 16),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          if (state.cartStatus == Status.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final totalPrice =
                              context.read<CartCubit>().totalPrice;

                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Sub Total',
                                    style: TextStyle(
                                      color: ColorManager.gray,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${totalPrice.toStringAsFixed(0)}\$',
                                    style: TextStyle(
                                      color: ColorManager.gray,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Delivery Fee',
                                    style: TextStyle(
                                      color: ColorManager.gray,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '10\$',
                                    style: TextStyle(
                                      color: ColorManager.gray,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${(totalPrice + 10).toStringAsFixed(0)}\$',
                                    style: const TextStyle(
                                      color: ColorManager.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              buildConfirmOrderButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildConfirmOrderButton(BuildContext context) {
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state.status == Status.success || state.status == Status.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final selectedMethod =context.read<PaymentMethodCubit>().state;

        final totalPrice = context.read<CartCubit>().totalPrice;

        return BlocBuilder<SavedAddressCubit, AddressState>(
          builder: (context, addState) {
            return Column(
              children: [
                CustomButton(
                  onPressed: () {
                    if (state.status == Status.loading) return;
                    if (addState is AddressSuccess &&
                        addState.addresses.isNotEmpty) {
                      final address =
                          addState.addresses[int.parse(
                            context.read<CheckoutCubit>().SelectedAddrees,
                          )];
                      if (selectedMethod == 'Cash on delivery') {
                        context.read<CheckoutCubit>().placeCashOrder(
                          RequestShippingBody(
                            shippingAddress: ShippingAddress(
                              city: address.city,
                              lat: address.lat,
                              long: address.long,
                              phone: address.phone,
                              street: address.street,
                            ),
                          ),
                        );
                      } else {
                        log(selectedMethod);
                        context.read<CheckoutCubit>().placeCreditOrder(
                          RequestShippingBody(
                            shippingAddress: ShippingAddress(
                              city: address.city,
                              lat: address.lat,
                              long: address.long,
                              phone: address.phone,
                              street: address.street,
                            ),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please add Address')),
                      );
                    }
                  },
                  text: 'Place Order',
                ),
                const SizedBox(height: 16),
                if (state.status == Status.loading)
                  const CircularProgressIndicator(),
              ],
            );
          },
        );
      },
    );
  }
}
