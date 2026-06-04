import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_app_button.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/domain/address/entity/address_entity.dart';
import 'package:e_commerce_application/presentation/address/bloc/address_cubit.dart';

class AddEditAddressPage extends StatefulWidget {
  final AddressEntity? address;

  const AddEditAddressPage({this.address, super.key});

  @override
  State<AddEditAddressPage> createState() => _AddEditAddressPageState();
}

class _AddEditAddressPageState extends State<AddEditAddressPage> {
  final _formKey = GlobalKey<FormState>();
  
  late String _label;
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressLine1Controller;
  late final TextEditingController _addressLine2Controller;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _pinCodeController;
  late bool _isDefault;

  @override
  void initState() {
    super.initState();
    _label = widget.address?.label ?? 'Home';
    _fullNameController = TextEditingController(text: widget.address?.fullName);
    _phoneController = TextEditingController(text: widget.address?.phone);
    _addressLine1Controller = TextEditingController(text: widget.address?.addressLine1);
    _addressLine2Controller = TextEditingController(text: widget.address?.addressLine2);
    _cityController = TextEditingController(text: widget.address?.city);
    _stateController = TextEditingController(text: widget.address?.state);
    _pinCodeController = TextEditingController(text: widget.address?.pinCode);
    _isDefault = widget.address?.isDefault ?? false;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.address != null;

    return Scaffold(
      appBar: CustomAppBar(
        title: isEdit ? 'Edit Address' : 'Add Address',
        leadingIconData: Icons.arrow_back,
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Address Type',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Row(
                children: ['Home', 'Work', 'Other'].map((type) {
                  final isSelected = _label == type;
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: ChoiceChip(
                      label: Text(type),
                      selected: isSelected,
                      selectedColor: AppColors.kPrimaryColor.withValues(alpha: 0.2),
                      checkmarkColor: AppColors.kPrimaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? AppColors.kPrimaryColor : AppColors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _label = type;
                          });
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (val) => val == null || val.isEmpty ? 'Please enter full name' : null,
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (val) => val == null || val.isEmpty ? 'Please enter phone number' : null,
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: _addressLine1Controller,
                decoration: const InputDecoration(labelText: 'Address Line 1'),
                validator: (val) => val == null || val.isEmpty ? 'Please enter address line 1' : null,
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: _addressLine2Controller,
                decoration: const InputDecoration(labelText: 'Address Line 2 (Optional)'),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(labelText: 'City'),
                      validator: (val) => val == null || val.isEmpty ? 'Enter city' : null,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextFormField(
                      controller: _stateController,
                      decoration: const InputDecoration(labelText: 'State'),
                      validator: (val) => val == null || val.isEmpty ? 'Enter state' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: _pinCodeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'PIN Code'),
                validator: (val) => val == null || val.isEmpty ? 'Please enter PIN code' : null,
              ),
              SizedBox(height: 12.h),
              SwitchListTile(
                title: const Text('Set as Default Address'),
                activeColor: AppColors.kPrimaryColor,
                value: _isDefault,
                onChanged: (val) {
                  setState(() {
                    _isDefault = val;
                  });
                },
              ),
              SizedBox(height: 24.h),
              BasicAppButton(
                title: isEdit ? 'Save Changes' : 'Add Address',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final addressEntity = AddressEntity(
                      id: widget.address?.id ?? '',
                      label: _label,
                      fullName: _fullNameController.text,
                      phone: _phoneController.text,
                      addressLine1: _addressLine1Controller.text,
                      addressLine2: _addressLine2Controller.text.isEmpty
                          ? null
                          : _addressLine2Controller.text,
                      city: _cityController.text,
                      state: _stateController.text,
                      pinCode: _pinCodeController.text,
                      isDefault: _isDefault,
                    );

                    if (isEdit) {
                      context.read<AddressCubit>().updateAddress(addressEntity);
                    } else {
                      context.read<AddressCubit>().addAddress(addressEntity);
                    }
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
