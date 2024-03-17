part of 'delete_account_cubit.dart';

@immutable
abstract class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object> get props => [];
}

class DeleteAccountInitial extends DeleteAccountState {}

///DeleteAccount
class DeleteAccountLoadingState extends DeleteAccountState {}

class DeleteAccountSuccessState extends DeleteAccountState {
  // late final String message;
  const DeleteAccountSuccessState();
}

class DeleteAccountErrorState extends DeleteAccountState {
  final String error;
  const DeleteAccountErrorState(this.error);
}
