part of 'verify_account_cubit.dart';

@immutable
abstract class VerifyAccountState extends Equatable {
  const VerifyAccountState();

  @override
  List<Object> get props => [];
}

class VerifyAccountInitial extends VerifyAccountState {}

///verify states
class VerifyLoadingState extends VerifyAccountState {}

class VerifyLoadedState extends VerifyAccountState {
  final Map<String, dynamic> verifyData;
  const VerifyLoadedState(this.verifyData);
}

class VerifyUserLoadedState extends VerifyAccountState {
  final UserDataModel verifyData;
  const VerifyUserLoadedState(this.verifyData);
}

class VerifyErrorState extends VerifyAccountState {
  final String error;
  const VerifyErrorState(this.error);
}

///resend states
class ResendLoadingState extends VerifyAccountState {}

class ResendLoadedState extends VerifyAccountState {
  // uncomment it
  final Map<String, dynamic> data;
  // VerifyLoadedState(this.verifyData);
  const ResendLoadedState(this.data);
}

class ResendErrorState extends VerifyAccountState {
  final String error;
  const ResendErrorState(this.error);
}
