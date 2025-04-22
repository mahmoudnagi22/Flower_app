import 'package:flower_app/features/saved_address/data/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAddressCard extends StatelessWidget {
  const CustomAddressCard({super.key, required this.address});
  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    5.horizontalSpace,
                    Text(
                      address.city,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.delete,
                        color: Color(0xffCC1010),
                        size: 22,
                      ),
                    ),
                    12.horizontalSpace,
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            12.verticalSpace,
            Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                '2XVP+XC - Sheikh Zayed',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
