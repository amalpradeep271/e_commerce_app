import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'internet_connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityCubit() : super(ConnectivityInitial()) {
    _monitorInternet();
  }

  void _monitorInternet() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      final result =
          results.isNotEmpty ? results.first : ConnectivityResult.none;
      _emitConnectivityState(result);
    });
  }

  // Manual check for connectivity (used in "Retry" button)
  Future<void> checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
    _emitConnectivityState(result);
  }

  void _emitConnectivityState(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      emit(ConnectivityDisconnected());
    } else {
      emit(ConnectivityConnected());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
