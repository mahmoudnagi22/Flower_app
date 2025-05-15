import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/features/checkout_page/presentation/cubit/select_address_cubit.dart';
import 'package:flower_app/features/checkout_page/presentation/widgets/addresses_card.dart';
import 'package:flower_app/features/saved_address/domain/entities/address_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdderessWidget extends StatelessWidget {
  AdderessWidget({required this.addresses,required this.selected});
  final List<AddressEntity> addresses;
  SelectAddressCubit selectAddressCubit = getIt<SelectAddressCubit>();
  void Function(String index)selected;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => selectAddressCubit,
      child: BlocBuilder<SelectAddressCubit,String>(
        builder: (context, state) {
          return Container(
            child: Column(
              children: [
                ...addresses.map(
                  (address) => AddressesCard(
                    addressEntity: address,
                    value: addresses.indexOf(address).toString(),
                    groupValue: state,
                    onChanged: (val) {
                      selectAddressCubit.selectMethod(val);
                      selected(val);
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.addAddress);
                    },
                    label: Text(
                      'Add new',
                      style: TextStyle(color: ColorManager.appColor),
                    ),
                    icon: Icon(Icons.add, color: ColorManager.appColor),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
