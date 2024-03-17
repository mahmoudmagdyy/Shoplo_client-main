part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

///ForgetPassword states
class ForgetPasswordLoadingState extends UserState {}

class ForgetPasswordLoadedState extends UserState {
  late final Map<String, dynamic> data;
  ForgetPasswordLoadedState(this.data);
}

class ForgetPasswordErrorState extends UserState {
  final String error;
  final bool? isActive;
  ForgetPasswordErrorState(this.error, this.isActive);
}

// ///resend states
// class ResendLoadingState extends UserState {}
//
// class ResendLoadedState extends UserState {
//   // uncomment it
//   late final Map<String, dynamic> data;
//   // VerifyLoadedState(this.verifyData);
//   ResendLoadedState(this.data);
// }
//
// class ResendErrorState extends UserState {
//   final String error;
//   ResendErrorState(this.error);
// }

///resetPassword states
class ResetPasswordLoadingState extends UserState {}

class ResetPasswordLoadedState extends UserState {
  late final Map<String, dynamic> data;
  ResetPasswordLoadedState(this.data);
}

class ResetPasswordErrorState extends UserState {
  final String error;
  ResetPasswordErrorState(this.error);
}

// ///ChangePassword states
// class ChangePasswordLoadingState extends UserState {}
//
// class ChangePasswordLoadedState extends UserState {
//   late final Map<String, dynamic> data;
//   ChangePasswordLoadedState(this.data);
// }
//
// class ChangePasswordErrorState extends UserState {
//   final String error;
//   ChangePasswordErrorState(this.error);
// }

///logout
class LogoutLoadingState extends UserState {}

class LogoutSuccessState extends UserState {
  // late final String message;
  LogoutSuccessState();
}

class LogoutErrorState extends UserState {
  final String error;
  LogoutErrorState(this.error);
}

//lat long
class UserLatLong extends UserState {}

class SetUserLatLong extends UserState {}

class SetUserData extends UserState {}

class SetUserLocation extends UserState {
  final Map location;
  SetUserLocation(this.location);
}
