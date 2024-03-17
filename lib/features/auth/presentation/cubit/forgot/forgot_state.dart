part of 'forgot_cubit.dart';

@immutable
abstract class ForgotState extends Equatable {
  const ForgotState();

  @override
  List<Object> get props => [];
}

class ForgotInitial extends ForgotState {}

///ForgetPassword states
class ForgetPasswordLoadingState extends ForgotState {}

class ForgetPasswordLoadedState extends ForgotState {
  late final Map<String, dynamic> data;
  ForgetPasswordLoadedState(this.data);
}

class ForgetPasswordErrorState extends ForgotState {
  final String error;
  final int statusCode;
  ForgetPasswordErrorState(this.error, this.statusCode);
}