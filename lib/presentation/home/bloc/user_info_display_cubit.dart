import 'package:e_commerce_application/domain/auth/usecase/get_user_usecase.dart';
import 'package:e_commerce_application/presentation/home/bloc/user_info_display_state.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoDisplayCubit extends Cubit<UserInfoDisaplyState> {
  UserInfoDisplayCubit() : super(UserInfoDisaplyLoading());

  void displayUserInfo() async {
    var returnedData = await sl<GetUserUseCase>().call();
    returnedData.fold(
      (error) {
        emit(
          UserInfoDisaplyFailure(),
        );
      },
      (data) {
        emit(
          UserInfoDisaplyLoaded(user: data),
        );
      },
    );
  }
}
