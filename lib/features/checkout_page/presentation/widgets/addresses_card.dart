import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddressesCard extends StatelessWidget {
  final String label;
  final String groupValue;
  final ValueChanged<String> onChanged;
  final String street;
  const AddressesCard({
    super.key,
    required this.label,
    required this.groupValue,
    required this.onChanged,
    required this.street
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onChanged(label),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment:  CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: label,
                        activeColor: ColorManager.appColor,
                        groupValue: groupValue,
                        onChanged: (value) {
                          if (value != null) onChanged(value);
                        },
                      ),
                      const SizedBox(width: 8),
                      Text(label, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(street,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400
                    ),
                    ),
                  )
                ],
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.edit),),
            ],
          ),
        ),
      ),
    );
  }
}
