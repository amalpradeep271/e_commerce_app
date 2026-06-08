import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/common/bloc/button/button_state.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonStateCubit extends Cubit<ButtonState> {
  ButtonStateCubit() : super(ButtonInitialState());

  Future<void> execute({dynamic params, required UseCase usecase}) async {
    if (isClosed) return;
    emit(ButtonLoadingState());
    try {
      Either returnedData = await usecase.call(params: params);
      if (isClosed) return;
      returnedData.fold((error) {
        if (!isClosed) emit(ButtonFailureState(errorMessage: error));
      }, (data) {
        if (!isClosed) emit(ButtonSuccessState(successMessage: data));
      });
    } catch (e) {
      if (!isClosed) emit(ButtonFailureState(errorMessage: e.toString()));
    }
  }
}
