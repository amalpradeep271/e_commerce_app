import 'package:flutter_bloc/flutter_bloc.dart';

enum BottomNavItem { home, orders, wishlist, settings }

class BottomNavigationCubit extends Cubit<BottomNavItem> {
  BottomNavigationCubit() : super(BottomNavItem.home);

  void changeTabIndex(BottomNavItem item) {
    emit(item);
  }
}
