import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({super.key, required this.controller, required this.hintText, this.keyboardType, this.validator});
  final TextEditingController controller ;
  final String hintText;
  TextInputType? keyboardType;
   String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType?? TextInputType.text,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }
}
