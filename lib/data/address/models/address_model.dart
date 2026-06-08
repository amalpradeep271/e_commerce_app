import 'package:e_commerce_application/domain/address/entity/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.id,
    required super.label,
    required super.fullName,
    required super.phone,
    required super.addressLine1,
    super.addressLine2,
    required super.city,
    required super.state,
    required super.pinCode,
    required super.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String,
      label: json['label'] as String,
      fullName: json['fullName'] as String,
      phone: json['phone'] as String,
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String?,
      city: json['city'] as String,
      state: json['state'] as String,
      pinCode: json['pinCode'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'fullName': fullName,
      'phone': phone,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'pinCode': pinCode,
      'isDefault': isDefault,
    };
  }
}

extension AddressEntityX on AddressEntity {
  AddressModel toModel() {
    return AddressModel(
      id: id,
      label: label,
      fullName: fullName,
      phone: phone,
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      city: city,
      state: state,
      pinCode: pinCode,
      isDefault: isDefault,
    );
  }
}
