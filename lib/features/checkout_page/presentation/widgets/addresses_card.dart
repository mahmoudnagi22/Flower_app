import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/features/saved_address/domain/entities/address_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddressesCard extends StatelessWidget {
  final String groupValue;
  final ValueChanged<String> onChanged;
  final String value;
  final AddressEntity addressEntity;
  const AddressesCard({
    super.key,
    required this.addressEntity,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onChanged(value),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: value,
                          activeColor: ColorManager.appColor,
                          groupValue: groupValue,
                          onChanged: (value) {
                            if (value != null) onChanged(value);
                          },
                        ),
                        const SizedBox(width: 8),
                        Text(addressEntity.city, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        softWrap: true,
                        addressEntity.street,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
            ],
          ),
        ),
      ),
    );
  }
}
