import 'package:e_commerce_application/domain/auth/entity/user_entity.dart';

abstract class UserInfoDisaplyState {}

class UserInfoDisaplyLoading extends UserInfoDisaplyState {}

class UserInfoDisaplyLoaded extends UserInfoDisaplyState {
  final UserEntity user;

  UserInfoDisaplyLoaded({required this.user});
}

class UserInfoDisaplyFailure extends UserInfoDisaplyState {
}
