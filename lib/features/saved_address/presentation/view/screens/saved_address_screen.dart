import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_button.dart';
import 'package:flower_app/features/saved_address/presentation/view/widgets/custom_address_card.dart';
import 'package:flower_app/features/saved_address/presentation/view_model/address_cubit.dart';
import 'package:flower_app/features/saved_address/presentation/view_model/address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedAddressScreen extends StatelessWidget {
  const SavedAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddressCubit>()..getAddresses(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Saved address',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            if (state is AddressLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AddressError) {
              return Center(child: Text(state.message));
            } else if (state is AddressSuccess) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.addresses.length,
                        itemBuilder: (context, index) {
                          final address = state.addresses[index];
                          return CustomAddressCard(address: address);
                        },
                      ),
                    ),
                    CustomButton(onPressed: () {}, text: 'Add new address'),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
