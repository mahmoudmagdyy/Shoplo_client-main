part of 'change_password_cubit.dart';

@immutable
abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

///ChangePassword states
class ChangePasswordLoadingState extends ChangePasswordState {}

class ChangePasswordLoadedState extends ChangePasswordState {
   final Map<String, dynamic> data;
  const ChangePasswordLoadedState(this.data);
}

class ChangePasswordErrorState extends ChangePasswordState {
  final String error;
  const ChangePasswordErrorState(this.error);
}
