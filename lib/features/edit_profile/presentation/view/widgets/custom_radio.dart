import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadio extends StatelessWidget {
  CustomRadio({
    super.key,
    required this.gender,
    required this.selectedGender,
    required this.onTap,
  });
  String gender;
  String selectedGender;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.pink, width: 2),
            ),
            child:
                isSelected
                    ? Container(
                      decoration: const BoxDecoration(
                        color: Colors.pink,
                        shape: BoxShape.circle,
                      ),
                    )
                    : Container(),
          ),
          8.horizontalSpace,
          Text(
            gender,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
