import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/injection.dart';
import '../../data/models/transaction.dart';
import '../../data/repositories/wallet_repository.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  static WalletCubit get(context) => BlocProvider.of(context);

  final repository = serviceLocator.get<WalletRepository>();

  final List<TransactionModel> wallet = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  bool loadingMoreResults = false;
  Map<String, dynamic> query = {
    'page': 1,
    'per_page': 10,
  };

  /// getWallet
  void getWallet(Map<String, dynamic> queryData) {
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      query.clear();
      query['page'] = 1;
      query['per_page'] = 10;
      query.addAll(queryData);
    }

    if (query['page'] == 1) {
      emit(WalletLoadingState());
    } else {
      loadingMoreResults = true;
      emit(WalletLoadingNextPageState());
    }

    repository.getWalletTransactions(query).then(
      (value) {
        wallet.clear();
        loadingMoreResults = false;
        debugPrint('VALUE 3333 : $value}', wrapWidth: 1024);
        if (value.errorMessages != null) {
          emit(WalletErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(WalletErrorState(value.errors!));
        } else {
          endLoadingFirstTime = true;
          List<TransactionModel> wallet1 = [];
          value.data.forEach((item) {
            wallet1.add(TransactionModel.fromJson(item));
          });

          debugPrint('_wallet ${wallet1.length}');
          if (query['page'] != 1) {
            debugPrint('----- lode more ');
            wallet.addAll(wallet1);
          } else {
            wallet.clear();
            wallet.addAll(wallet1);
          }
          if (wallet.length == value.meta['total']) {
            debugPrint('============== done request');
            hasReachedEndOfResults = true;
          } else if (wallet.length < value.meta['total']) {
            hasReachedEndOfResults = false;
          }
          debugPrint('Wallet ${wallet.length}');
          if (query['page'] < value.meta['last_page']) {
            debugPrint('load more 2222 page ++ ');
            query['page'] += 1;
          } else {
            query['page'] = 1;
          }

          emit(WalletSuccessState(wallet, value.total!.toString()));
        }
      },
    );
  }
}
