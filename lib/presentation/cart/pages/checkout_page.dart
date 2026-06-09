import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_application/common/bloc/button/button_state_cubit.dart';
import 'package:e_commerce_application/common/helper/cart/cart_helper.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_reactive_button.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_app_button.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';
import 'package:e_commerce_application/domain/address/entity/address_entity.dart';
import 'package:e_commerce_application/presentation/address/bloc/address_cubit.dart';
import 'package:e_commerce_application/presentation/address/bloc/address_state.dart';
import 'package:e_commerce_application/presentation/address/pages/add_edit_address_page.dart';
import 'package:e_commerce_application/presentation/cart/bloc/coupon_cubit.dart';
import 'package:e_commerce_application/presentation/cart/bloc/coupon_state.dart';
import 'package:e_commerce_application/presentation/cart/bloc/payment_cubit.dart';
import 'package:e_commerce_application/presentation/cart/bloc/payment_state.dart';
import 'package:e_commerce_application/presentation/cart/pages/order_placed_page.dart';

class CheckOutPage extends StatefulWidget {
  final List<ProductOrderedEntity> products;
  final dynamic shipping;
  final dynamic tax;

  const CheckOutPage({
    super.key,
    required this.products,
    required this.shipping,
    required this.tax,
  });

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final TextEditingController _couponCon = TextEditingController();
  AddressEntity? _selectedAddress;
  double _couponDiscount = 0.0;
  String? _appliedCouponCode;

  @override
  void dispose() {
    _couponCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = CartHelper.calculateCartSubtotal(widget.products);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Checkout',
        leadingIconData: Icons.arrow_back,
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ButtonStateCubit()),
          BlocProvider(create: (context) => PaymentCubit()),
          BlocProvider(create: (context) => AddressCubit()..loadAddresses()),
          BlocProvider(create: (context) => CouponCubit()),
        ],
        child: Builder(
          builder: (context) {
            final double total = subtotal + widget.shipping + widget.tax - _couponDiscount;
            
            return MultiBlocListener(
              listeners: [
                BlocListener<PaymentCubit, PaymentState>(
                  listener: (context, state) {
                    if (state is PaymentSuccess) {
                      context.read<PaymentCubit>().placeOrder(
                            shippingAddress: _formatAddress(_selectedAddress!),
                            products: widget.products,
                            shipping: widget.shipping,
                            tax: widget.tax,
                            totalPrice: total,
                          );
                    } else if (state is PaymentFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    } else if (state is OrderPlacedSuccessfully) {
                      AppNavigator.pushAndRemove(context, const OrderPlacedPage());
                    }
                  },
                ),
                BlocListener<CouponCubit, CouponState>(
                  listener: (context, state) {
                    if (state is CouponValidationSuccess) {
                      setState(() {
                        _couponDiscount = state.coupon.discountAmount;
                        _appliedCouponCode = state.coupon.code;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Coupon applied successfully!')),
                      );
                    } else if (state is CouponValidationFailure) {
                      setState(() {
                        _couponDiscount = 0.0;
                        _appliedCouponCode = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                ),
                BlocListener<AddressCubit, AddressState>(
                  listener: (context, state) {
                    if (state is AddressLoaded && state.addresses.isNotEmpty) {
                      // Automatically select default address, or the first address
                      final defaultAddr = state.addresses.firstWhere(
                        (a) => a.isDefault,
                        orElse: () => state.addresses.first,
                      );
                      setState(() {
                        _selectedAddress = defaultAddr;
                      });
                    }
                  },
                ),
              ],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 1. Shipping Address Section
                            _sectionHeader('Shipping Address'),
                            SizedBox(height: 8.h),
                            _addressSelectionCard(context),
                            
                            SizedBox(height: 24.h),
                            
                            // 2. Coupon Section
                            _sectionHeader('Promo Coupon'),
                            SizedBox(height: 8.h),
                            _couponInputField(context, subtotal),
                            
                            SizedBox(height: 24.h),
                            
                            // 3. Price Breakdown Section
                            _sectionHeader('Payment Summary'),
                            SizedBox(height: 8.h),
                            _priceSummaryCard(subtotal),
                          ],
                        ),
                      ),
                    ),
                    
                    // 4. Place Order Reactive Button
                    BlocBuilder<PaymentCubit, PaymentState>(
                      builder: (context, state) {
                        return BasicReactiveButton(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹ ${total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const Text(
                                'Pay & Place Order',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            if (_selectedAddress == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please select a shipping address')),
                              );
                              return;
                            }

                            context.read<PaymentCubit>().makePayment(
                                  amount: total,
                                  shippingAddress: _formatAddress(_selectedAddress!),
                                  products: widget.products,
                                  shipping: widget.shipping,
                                  tax: widget.tax,
                                );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.titleMedium(context),
    );
  }

  Widget _addressSelectionCard(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        if (state is AddressLoading && _selectedAddress == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_selectedAddress == null) {
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: const BorderSide(color: AppColors.colorDivider),
            ),
            child: InkWell(
              onTap: () => _showAddressSelectionBottomSheet(context),
              borderRadius: BorderRadius.circular(12.r),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_location, color: AppColors.kPrimaryColor),
                    SizedBox(width: 8.w),
                    Text(
                      'Select Shipping Address',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            _selectedAddress!.label.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        ),
                        if (_selectedAddress!.isDefault) ...[
                          SizedBox(width: 8.w),
                          Text(
                            '(Default)',
                            style: TextStyle(fontSize: 11.sp, color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ],
                    ),
                    TextButton(
                      onPressed: () => _showAddressSelectionBottomSheet(context),
                      child: const Text('Change', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  _selectedAddress!.fullName,
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                Text(
                  _selectedAddress!.phone,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${_selectedAddress!.addressLine1}${_selectedAddress!.addressLine2 != null ? ', ${_selectedAddress!.addressLine2}' : ''}',
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
                ),
                Text(
                  '${_selectedAddress!.city}, ${_selectedAddress!.state} - ${_selectedAddress!.pinCode}',
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _couponInputField(BuildContext context, double subtotal) {
    final couponCubit = context.read<CouponCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _couponCon,
                enabled: _appliedCouponCode == null,
                decoration: InputDecoration(
                  hintText: 'Enter Promo Coupon Code',
                  suffixIcon: _appliedCouponCode != null
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.red),
                          onPressed: () {
                            couponCubit.resetCoupon();
                            setState(() {
                              _couponDiscount = 0.0;
                              _appliedCouponCode = null;
                              _couponCon.clear();
                            });
                          },
                        )
                      : null,
                ),
              ),
            ),
            if (_appliedCouponCode == null) ...[
              SizedBox(width: 12.w),
              BasicAppButton(
                onPressed: () {
                  final code = _couponCon.text.trim();
                  if (code.isNotEmpty) {
                    couponCubit.validateCoupon(code, subtotal);
                  }
                },
                width: 90.w,
                height: 48.h,
                title: 'Apply',
              ),
            ],
          ],
        ),
        if (_appliedCouponCode != null) ...[
          SizedBox(height: 8.h),
          Text(
            "Promo Coupon '$_appliedCouponCode' applied successfully!",
            style: TextStyle(color: Colors.green, fontSize: 13.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ],
    );
  }

  Widget _priceSummaryCard(double subtotal) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _priceRow('Subtotal', subtotal),
            SizedBox(height: 8.h),
            _priceRow('Delivery Charges', widget.shipping),
            SizedBox(height: 8.h),
            _priceRow('Tax', widget.tax),
            if (_couponDiscount > 0) ...[
              SizedBox(height: 8.h),
              _priceRow('Coupon Discount', -_couponDiscount, isDiscount: true),
            ],
            SizedBox(height: 12.h),
            const Divider(),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Total',
                  style: AppTextStyles.titleMedium(context),
                ),
                Text(
                  '₹ ${(subtotal + widget.shipping + widget.tax - _couponDiscount).toStringAsFixed(2)}',
                  style: AppTextStyles.titleLarge(context).copyWith(
                    color: AppColors.getPrimary(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String label, dynamic value, {bool isDiscount = false}) {
    final doubleVal = (value as num).toDouble();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium(context).copyWith(
            color: isDark ? Colors.grey[400] : Colors.grey[700],
          ),
        ),
        Text(
          isDiscount ? '- ₹ ${doubleVal.abs().toStringAsFixed(2)}' : '₹ ${doubleVal.toStringAsFixed(2)}',
          style: AppTextStyles.bodyMedium(context).copyWith(
            color: isDiscount ? Colors.green : (isDark ? AppColors.white : AppColors.black),
            fontWeight: isDiscount ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  String _formatAddress(AddressEntity address) {
    return '${address.fullName}\n${address.phone}\n${address.addressLine1}${address.addressLine2 != null ? ', ${address.addressLine2}' : ''}\n${address.city}, ${address.state} - ${address.pinCode}';
  }

  void _showAddressSelectionBottomSheet(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: parentContext.read<AddressCubit>()..loadAddresses(),
          child: Builder(
            builder: (context) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Address',
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: AppColors.kPrimaryColor),
                          onPressed: () {
                            Navigator.pop(context);
                            AppNavigator.push(
                              parentContext,
                              BlocProvider.value(
                                value: parentContext.read<AddressCubit>(),
                                child: const AddEditAddressPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Expanded(
                      child: BlocBuilder<AddressCubit, AddressState>(
                        builder: (context, state) {
                          if (state is AddressLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (state is AddressLoaded) {
                            if (state.addresses.isEmpty) {
                              return Center(
                                child: Text(
                                  'No saved addresses.',
                                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: state.addresses.length,
                              itemBuilder: (context, idx) {
                                final addr = state.addresses[idx];
                                final isSelected = _selectedAddress?.id == addr.id;

                                return Card(
                                  elevation: isSelected ? 2 : 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    side: BorderSide(
                                      color: isSelected ? AppColors.kPrimaryColor : AppColors.colorDivider,
                                      width: isSelected ? 2 : 1,
                                    ),
                                  ),
                                  margin: EdgeInsets.only(bottom: 8.h),
                                  child: ListTile(
                                    title: Text(
                                      '${addr.fullName} (${addr.label.toUpperCase()})',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                                    ),
                                    subtitle: Text(
                                      '${addr.addressLine1}, ${addr.city} - ${addr.pinCode}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                    trailing: isSelected
                                        ? const Icon(Icons.check_circle, color: AppColors.kPrimaryColor)
                                        : null,
                                    onTap: () {
                                      setState(() {
                                        _selectedAddress = addr;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        );
      },
    );
  }
}
