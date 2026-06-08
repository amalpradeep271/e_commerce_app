import 'package:e_commerce_application/domain/auth/usecase/get_ages_usecase.dart';
import 'package:e_commerce_application/presentation/auth/bloc/ages_display_state.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgesDisplayCubit extends Cubit<AgesDisplayState> {

  AgesDisplayCubit() : super(AgesLoading());

  void displayAges() async {
    if (isClosed) return;
    var returnedData = await sl<GetAgesUseCase>().call();
    if (isClosed) return;

    returnedData.fold(
      (message) {
        if (!isClosed) {
          emit(
            AgesLoadFailure(message: message)
          );
        }
      },
      (data) {
        if (!isClosed) {
          emit(
            AgesLoaded(ages: data)
          );
        }
      }
    );
  }
}