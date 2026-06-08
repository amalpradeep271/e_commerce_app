import 'package:e_commerce_application/domain/auth/entity/user_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;
  ProfileLoaded({required this.user});
}

class ProfileFailure extends ProfileState {
  final String errorMessage;
  ProfileFailure({required this.errorMessage});
}

class AvatarUploadSuccess extends ProfileState {
  final String imageUrl;
  AvatarUploadSuccess({required this.imageUrl});
}
