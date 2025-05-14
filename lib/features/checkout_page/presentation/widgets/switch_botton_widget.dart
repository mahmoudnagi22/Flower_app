import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

class SwitchDialogExample extends StatefulWidget {
  const SwitchDialogExample({super.key});

  @override
  State<SwitchDialogExample> createState() => _SwitchDialogExampleState();
}

class _SwitchDialogExampleState extends State<SwitchDialogExample> {
  bool _isSwitched = false;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Switch(
                value: _isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    _isSwitched = value;
                  });
                },
                activeColor: ColorManager.appColor,
                inactiveThumbColor: ColorManager.white,
              ),
              const SizedBox(width: 10),
              const Text(
                'it is a gift',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),

          if (_isSwitched) ...[
            const SizedBox(height: 16),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _controller2,
                      labelText: 'Name',
                      hintText: 'Enter the name',
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      controller: _controller2,
                      labelText: 'phone number',
                      hintText: 'Enter the phone number',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
