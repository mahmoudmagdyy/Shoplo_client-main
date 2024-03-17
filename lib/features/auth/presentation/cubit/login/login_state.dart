part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

///LogIn
class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState {
  final User loginData;
  final String accessToken;
  const LoginLoadedState(this.loginData, this.accessToken);
}

class LoginErrorState extends LoginState {
  final String error;
  final int statusCode;
  const LoginErrorState(this.error, this.statusCode);
}
