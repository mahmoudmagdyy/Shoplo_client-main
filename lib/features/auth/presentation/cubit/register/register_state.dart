part of 'register_cubit.dart';

@immutable
abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

///signUp states
class RegisterLoadingState extends RegisterState {}

class RegisterLoadedState extends RegisterState {
  late final String RegisterData;

  // late final String accessToken;
  RegisterLoadedState(this.RegisterData
      // , this.accessToken
      );
}

class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);
}
