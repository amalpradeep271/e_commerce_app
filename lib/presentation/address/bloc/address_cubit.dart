import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_application/domain/address/entity/address_entity.dart';
import 'package:e_commerce_application/domain/address/usecase/get_addresses_usecase.dart';
import 'package:e_commerce_application/domain/address/usecase/add_address_usecase.dart';
import 'package:e_commerce_application/domain/address/usecase/update_address_usecase.dart';
import 'package:e_commerce_application/domain/address/usecase/delete_address_usecase.dart';
import 'package:e_commerce_application/presentation/address/bloc/address_state.dart';
import 'package:e_commerce_application/service_locator.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  Future<void> loadAddresses() async {
    emit(AddressLoading());
    final result = await sl<GetAddressesUseCase>().call();
    result.fold(
      (error) => emit(AddressFailure(errorMessage: error)),
      (addresses) => emit(AddressLoaded(addresses: addresses)),
    );
  }

  Future<void> addAddress(AddressEntity address) async {
    emit(AddressLoading());
    final result = await sl<AddAddressUseCase>().call(params: address);
    result.fold(
      (error) => emit(AddressFailure(errorMessage: error)),
      (createdAddress) {
        emit(AddressActionSuccess(successMessage: 'Address added successfully'));
        loadAddresses();
      },
    );
  }

  Future<void> updateAddress(AddressEntity address) async {
    emit(AddressLoading());
    final result = await sl<UpdateAddressUseCase>().call(params: address);
    result.fold(
      (error) => emit(AddressFailure(errorMessage: error)),
      (updatedAddress) {
        emit(AddressActionSuccess(successMessage: 'Address updated successfully'));
        loadAddresses();
      },
    );
  }

  Future<void> deleteAddress(String id) async {
    emit(AddressLoading());
    final result = await sl<DeleteAddressUseCase>().call(params: id);
    result.fold(
      (error) => emit(AddressFailure(errorMessage: error)),
      (successMessage) {
        emit(AddressActionSuccess(successMessage: 'Address deleted successfully'));
        loadAddresses();
      },
    );
  }
}
