part of 'verify_forgot_password_cubit.dart';

@immutable
abstract class VerifyForgotPasswordState extends Equatable {
  const VerifyForgotPasswordState();

  @override
  List<Object> get props => [];
}

class VerifyForgotPasswordInitial extends VerifyForgotPasswordState {}

///verify token states
class VerifyTokenLoadingState extends VerifyForgotPasswordState {}

class VerifyTokenLoadedState extends VerifyForgotPasswordState {
  // uncomment it
  late final Map<String, dynamic> verifyData;
  VerifyTokenLoadedState(this.verifyData);
// VerifyLoadedState();
}

class VerifyTokenErrorState extends VerifyForgotPasswordState {
  final String error;
  VerifyTokenErrorState(this.error);
}

///resend states
class ResendResetLoadingState extends VerifyForgotPasswordState {}

class ResendResetLoadedState extends VerifyForgotPasswordState {
  // uncomment it
  late final Map<String, dynamic> data;
  // VerifyLoadedState(this.verifyData);
  ResendResetLoadedState(this.data);
}

class ResendResetErrorState extends VerifyForgotPasswordState {
  final String error;
  ResendResetErrorState(this.error);
}