import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  final Connectivity connectivity = Connectivity();

  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  InternetConnectionCubit() : super(InternetConnectionLoadingState()) {
    monitorConnectionType();
  }

  void monitorConnectionType() async {
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) async {
          if (connectivityResult == ConnectivityResult.wifi) {
            emitConnectionType(ConnectivityResult.wifi);
          } else if (connectivityResult == ConnectivityResult.mobile) {
            emitConnectionType(ConnectivityResult.mobile);
          } else if (connectivityResult == ConnectivityResult.none) {
            emitInternetDisconnected();
          }
        });
  }

  void emitConnectionType(ConnectivityResult connectivityResult) =>
      emit(InternetConnectionSuccessState(connection: connectivityResult));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() async {
    connectivitySubscription!.cancel();
    return super.close();
  }
}
