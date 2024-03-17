part of 'logout_cubit.dart';

@immutable
abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

///logout
class LogoutLoadingState extends LogoutState {}

class LogoutSuccessState extends LogoutState {
  // late final String message;
  LogoutSuccessState();
}

class LogoutErrorState extends LogoutState {
  final String error;
  LogoutErrorState(this.error);
}