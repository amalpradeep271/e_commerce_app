import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_application/domain/user/usecase/get_user_usecase.dart';
import 'package:e_commerce_application/domain/user/usecase/upload_user_image_usecase.dart';
import 'package:e_commerce_application/presentation/settings/bloc/profile_state.dart';
import 'package:e_commerce_application/service_locator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    final result = await sl<GetUserProfileUseCase>().call();
    result.fold(
      (error) => emit(ProfileFailure(errorMessage: error)),
      (user) => emit(ProfileLoaded(user: user)),
    );
  }

  Future<void> uploadAvatar(File imageFile) async {
    emit(ProfileLoading());
    final result = await sl<UploadUserImageUsecase>().call(params: imageFile);
    result.fold(
      (error) => emit(ProfileFailure(errorMessage: error)),
      (imageUrl) {
        emit(AvatarUploadSuccess(imageUrl: imageUrl));
        loadProfile(); // Reload user profile to display new avatar
      },
    );
  }
}
