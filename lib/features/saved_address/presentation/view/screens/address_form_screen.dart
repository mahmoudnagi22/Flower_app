import 'package:flower_app/features/saved_address/domain/entities/address_entity.dart';
import 'package:flower_app/features/saved_address/presentation/view_model/address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressFormScreen extends StatefulWidget {
  final AddressEntity? address;
  const AddressFormScreen({super.key, this.address});

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController nameController;
  String selectedCity = 'Cairo';
  String selectedArea = 'October';

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController(text: widget.address?.lat ?? '');
    phoneController = TextEditingController(text: widget.address?.phone ?? '');
    nameController = TextEditingController(
      text: widget.address?.userName ?? '',
    );
    selectedCity = widget.address?.city ?? 'Cairo';
    selectedArea = widget.address?.street ?? 'October';
  }

  @override
  void dispose() {
    addressController.dispose();
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      final address = AddressEntity(
        id: widget.address?.id ?? 0,
        lat: addressController.text,
        phone: phoneController.text,
        userName: nameController.text,
        city: selectedCity,
        street: selectedArea,
        long: '',
      );
      if (widget.address == null) {
        context.read<AddressCubit>().addAddress(address);
      } else {
        context.read<AddressCubit>().updateAddress(address);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Address')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://via.placeholder.com/300x150.png?text=Map+Preview',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone number'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Recipient name'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedCity,
                      items:
                          ['Cairo', 'Alex']
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                      onChanged: (val) => setState(() => selectedCity = val!),
                      decoration: const InputDecoration(labelText: 'City'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedArea,
                      items:
                          ['October', 'Zayed']
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                      onChanged: (val) => setState(() => selectedArea = val!),
                      decoration: const InputDecoration(labelText: 'Area'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onSubmit,
                child: const Text('Save address'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
