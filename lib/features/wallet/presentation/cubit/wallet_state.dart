part of 'wallet_cubit.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoadingState extends WalletState {}

class WalletLoadingNextPageState extends WalletState {}

class WalletSuccessState extends WalletState {
  final List<TransactionModel> transactions;
  final String total;
  const WalletSuccessState(this.transactions, this.total);
}

class WalletErrorState extends WalletState {
  final String error;
  const WalletErrorState(this.error);
}
