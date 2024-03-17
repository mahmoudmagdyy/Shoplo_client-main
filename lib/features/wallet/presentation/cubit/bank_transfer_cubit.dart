import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/features/wallet/data/datasources/wallet_data_provider.dart';
import 'package:shoplo_client/features/wallet/data/repositories/wallet_repository.dart';

part 'bank_transfer_state.dart';

class BankTransferCubit extends Cubit<BankTransferState> {
  BankTransferCubit() : super(BankTransferInitial());
  static BankTransferCubit get(context) => BlocProvider.of(context);
  static final dataProvider = WalletDataProvider();
  static final WalletRepository repository = WalletRepository(dataProvider);

  void makeBankTransfer(values) async {
    emit(MakeTransactionsLoadingState());
    repository.getWalletTransactions(values).then(
      (value) {
        if (value.errorMessages != null) {
          emit(MakeTransactionsErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(MakeTransactionsErrorState(value.errors!));
        } else {
          debugPrint("printAddress ${value.data} ");
          emit(const MakeTransactionsSuccessState());
        }
      },
    );
  }
}
