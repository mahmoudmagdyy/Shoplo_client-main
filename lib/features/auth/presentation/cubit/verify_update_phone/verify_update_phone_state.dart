part of 'verify_update_phone_cubit.dart';

@immutable
abstract class VerifyUpdatePhoneState {}

class VerifyUpdatePhoneInitial extends VerifyUpdatePhoneState {}

///verify states
class VerifyUpdatePhoneLoadingState extends VerifyUpdatePhoneState {}

class VerifyUpdatePhoneLoadedState extends VerifyUpdatePhoneState {
  late final Map<String, dynamic> verifyData;
  VerifyUpdatePhoneLoadedState(this.verifyData);
}

class VerifyUpdatePhoneUserLoadedState extends VerifyUpdatePhoneState {
  late final UserDataModel verifyData;
  VerifyUpdatePhoneUserLoadedState(this.verifyData);
}

class VerifyUpdatePhoneErrorState extends VerifyUpdatePhoneState {
  final String error;
  VerifyUpdatePhoneErrorState(this.error);
}

///resend states
class ResendUpdatePhoneLoadingState extends VerifyUpdatePhoneState {}

class ResendUpdatePhoneLoadedState extends VerifyUpdatePhoneState {
  // uncomment it
  late final Map<String, dynamic> data;
  // VerifyLoadedState(this.verifyData);
  ResendUpdatePhoneLoadedState(this.data);
}

class ResendUpdatePhoneErrorState extends VerifyUpdatePhoneState {
  final String error;
  ResendUpdatePhoneErrorState(this.error);
}