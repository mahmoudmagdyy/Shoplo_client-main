part of 'reset_password_cubit.dart';

@immutable
abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

///resetPassword states
class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordLoadedState extends ResetPasswordState {
  late final Map<String, dynamic> data;
  ResetPasswordLoadedState(this.data);
}

class ResetPasswordErrorState extends ResetPasswordState {
  final String error;
  ResetPasswordErrorState(this.error);
}
