import 'package:e_commerce_application/domain/home/usecase/get_banners_usecase.dart';
import 'package:e_commerce_application/presentation/home/bloc/banners_display_state.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannersDisplayCubit extends Cubit<BannersDisplayState> {
  BannersDisplayCubit() : super(BannersLoading());

  void displayBanners() async {
    var returnedData = await sl<GetBannersUsecase>().call();
    returnedData.fold(
      (error) {
        emit(BannersLoadFailure());
      },
      (data) {
        emit(BannersLoaded(banners: data));
      },
    );
  }
}
