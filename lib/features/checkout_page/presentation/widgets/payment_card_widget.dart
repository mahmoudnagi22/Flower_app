import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentCard extends StatelessWidget {
  final String label;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const PaymentCard({
    super.key,
    required this.label,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onChanged(label),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
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
        ),
      ),
    );
  }
}
