part of 'internet_cubit.dart';

abstract class InternetConnectionState {}

class InternetConnectionLoadingState extends InternetConnectionState {}

class InternetConnectionSuccessState extends InternetConnectionState {
  final ConnectivityResult connection;
  InternetConnectionSuccessState({required this.connection});
}

class InternetDisconnected extends InternetConnectionState {}
