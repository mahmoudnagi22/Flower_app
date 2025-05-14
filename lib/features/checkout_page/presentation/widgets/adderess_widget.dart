import 'package:flower_app/features/checkout_page/presentation/widgets/addresses_card.dart';
import 'package:flower_app/features/saved_address/data/models/address_model.dart';
import 'package:flutter/widgets.dart';

class AdderessWidget extends StatelessWidget {
  const AdderessWidget({required this.addresses});
  final List<AddressModel> addresses;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ...addresses.map(
            (address) => AddressesCard(
              label: address.city,
              groupValue: "",
              street: address.street,
              onChanged: (val){},
            ),
          ),
        ],
      ),
    );
  }
}
