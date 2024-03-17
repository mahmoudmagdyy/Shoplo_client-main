import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/injection.dart';
import '../../data/models/bank_account.dart';
import '../../data/repositories/payment_repository.dart';

part 'bank_state.dart';

class BankCubit extends Cubit<BankState> {
  BankCubit() : super(BankInitial());

  static BankCubit get(context) => BlocProvider.of(context);
  final repository = serviceLocator.get<PaymentRepository>();
  List<BankAccountModel> bankAccounts = [];

  /// Get Bank Account
  void getBankAccounts() {
    emit(GetBanksLoadingState());

    repository.getBanks().then(
      (value) {
        debugPrint('value==>${value.toString()}');
        if (value.errorMessages != null) {
          emit(GetBanksErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetBanksErrorState(value.errors!));
        } else {
          bankAccounts.clear();
          value.data.forEach((item) {
            bankAccounts.add(BankAccountModel.fromJson(item));
          });
          emit(GetBanksSuccessState(bankAccounts));
        }
      },
    );
  }
}
