import 'package:e_commerce_application/core/constants/app_preference.dart';
import 'package:e_commerce_application/domain/auth/entity/user_entity.dart';
import 'package:e_commerce_application/domain/auth/usecase/get_user_usecase.dart';
import 'package:e_commerce_application/common/bloc/app_drawer/user_info_display_state.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoDisplayCubit extends Cubit<UserInfoDisaplyState> {
  UserInfoDisplayCubit() : super(UserInfoDisaplyLoading());

  void displayUserInfo() async {
    if (isClosed) return;
    var returnedData = await sl<GetUserUseCase>().call();
    if (isClosed) return;
    returnedData.fold(
      (error) {
        if (!isClosed) {
          emit(
            UserInfoDisaplyFailure(),
          );
        }
      },
      (data) async {
        UserEntity dat = data;
        final pref = AppPref();
        
        await pref.imageStorage.write(
          key: pref.imageKey,
          value: dat.image,
        );

        if (!isClosed) {
          emit(
            UserInfoDisaplyLoaded(user: data),
          );
        }
      },
    );
  }
}
