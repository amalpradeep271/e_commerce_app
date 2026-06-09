import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/domain/address/entity/address_entity.dart';
import 'package:e_commerce_application/presentation/address/bloc/address_cubit.dart';
import 'package:e_commerce_application/presentation/address/bloc/address_state.dart';
import 'package:e_commerce_application/presentation/address/pages/add_edit_address_page.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';

class AddressBookPage extends StatelessWidget {
  const AddressBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit()..loadAddresses(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Address Book',
              leadingIconData: Icons.arrow_back,
              onLeadingPressed: () => Navigator.pop(context),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF14B8A6) : AppColors.kPrimaryColor,
              onPressed: () {
                AppNavigator.push(
                  context,
                  BlocProvider.value(
                    value: context.read<AddressCubit>(),
                    child: const AddEditAddressPage(),
                  ),
                );
              },
              child: Icon(Icons.add, color: Theme.of(context).brightness == Brightness.dark ? Colors.black : AppColors.white),
            ),
            body: BlocConsumer<AddressCubit, AddressState>(
              listener: (context, state) {
                if (state is AddressActionSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.successMessage)),
                  );
                } else if (state is AddressFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                }
              },
              builder: (context, state) {
                if (state is AddressLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is AddressLoaded) {
                  if (state.addresses.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_off, size: 80.w, color: AppColors.grey),
                          SizedBox(height: 16.h),
                          Text(
                            'No addresses saved yet.',
                            style: TextStyle(fontSize: 16.sp, color: AppColors.lightGray),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    itemCount: state.addresses.length,
                    itemBuilder: (context, index) {
                      final address = state.addresses[index];
                      return _addressCard(context, address);
                    },
                  );
                }

                return Center(
                  child: ElevatedButton(
                    onPressed: () => context.read<AddressCubit>().loadAddresses(),
                    child: const Text('Try Again'),
                  ),
                );
              },
            ),
          );
        }
      ),
    );
  }

  Widget _addressCard(BuildContext context, AddressEntity address) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? const Color(0xFF14B8A6) : AppColors.kPrimaryColor;
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    address.label.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        AppNavigator.push(
                          context,
                          BlocProvider.value(
                            value: context.read<AddressCubit>(),
                            child: AddEditAddressPage(address: address),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<AddressCubit>().deleteAddress(address.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              address.fullName,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.h),
            Text(
              address.phone,
              style: TextStyle(fontSize: 14.sp, color: isDark ? Colors.grey[400] : Colors.grey[700]),
            ),
            SizedBox(height: 8.h),
            Text(
              address.addressLine1,
              style: TextStyle(fontSize: 14.sp),
            ),
            if (address.addressLine2 != null && address.addressLine2!.isNotEmpty)
              Text(
                address.addressLine2!,
                style: TextStyle(fontSize: 14.sp),
              ),
            Text(
              '${address.city}, ${address.state} - ${address.pinCode}',
              style: TextStyle(fontSize: 14.sp),
            ),
            if (address.isDefault) ...[
              SizedBox(height: 12.h),
              const Divider(),
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8.w),
                  Text(
                    'Default Address',
                    style: TextStyle(fontSize: 14.sp, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ] else ...[
              SizedBox(height: 12.h),
              const Divider(),
              InkWell(
                onTap: () {
                  final updatedAddress = AddressEntity(
                    id: address.id,
                    label: address.label,
                    fullName: address.fullName,
                    phone: address.phone,
                    addressLine1: address.addressLine1,
                    addressLine2: address.addressLine2,
                    city: address.city,
                    state: address.state,
                    pinCode: address.pinCode,
                    isDefault: true,
                  );
                  context.read<AddressCubit>().updateAddress(updatedAddress);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Row(
                    children: [
                      Icon(Icons.circle_outlined, color: isDark ? Colors.grey[500] : Colors.grey),
                      SizedBox(width: 8.w),
                      Text(
                        'Set as Default',
                        style: TextStyle(fontSize: 14.sp, color: isDark ? Colors.grey[400] : Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
