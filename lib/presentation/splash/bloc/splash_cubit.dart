import 'package:e_commerce_application/domain/auth/usecase/is_logged_in_usecase.dart';
import 'package:e_commerce_application/presentation/splash/bloc/splash_state.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 3));
    if (isClosed) return;
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isClosed) return;
    if (isLoggedIn) {
      emit(
        Authenticated(),
      );
    } else {
      emit(
        UnAuthenticated(),
      );
    }
  }
}
