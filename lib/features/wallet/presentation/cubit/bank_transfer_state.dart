part of 'bank_transfer_cubit.dart';

@immutable
abstract class BankTransferState extends Equatable {
  const BankTransferState();

  @override
  List<Object> get props => [];
}

class BankTransferInitial extends BankTransferState {}

class MakeTransactionsLoadingState extends BankTransferState {}

class MakeTransactionsLoadingNextPageState extends BankTransferState {}

class MakeTransactionsSuccessState extends BankTransferState {
  const MakeTransactionsSuccessState();
}

class MakeTransactionsErrorState extends BankTransferState {
  final String error;
  const MakeTransactionsErrorState(this.error);
}
