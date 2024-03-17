import '../../../../core/core_model/app_response.dart';

abstract class WalletInterface {
  Future<AppResponse> getWalletTransactions(query);
}
