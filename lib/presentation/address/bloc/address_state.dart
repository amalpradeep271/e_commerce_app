import 'package:e_commerce_application/domain/address/entity/address_entity.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<AddressEntity> addresses;
  AddressLoaded({required this.addresses});
}

class AddressFailure extends AddressState {
  final String errorMessage;
  AddressFailure({required this.errorMessage});
}

class AddressActionSuccess extends AddressState {
  final String successMessage;
  AddressActionSuccess({required this.successMessage});
}
