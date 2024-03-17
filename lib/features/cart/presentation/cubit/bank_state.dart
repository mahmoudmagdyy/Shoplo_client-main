part of 'bank_cubit.dart';

abstract class BankState extends Equatable {
  const BankState();

  @override
  List<Object> get props => [];
}

class BankInitial extends BankState {}

/// Get Bank Methods
class GetBanksLoadingState extends BankState {}

class GetBanksSuccessState extends BankState {
  final List<BankAccountModel> bankAccounts;
  const GetBanksSuccessState(this.bankAccounts);
}

class GetBanksErrorState extends BankState {
  final String error;
  const GetBanksErrorState(this.error);
}
