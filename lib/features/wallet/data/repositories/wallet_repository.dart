import '../../../../core/core_model/app_response.dart';
import '../../domain/repositories/wallet_interface.dart';
import '../datasources/wallet_data_provider.dart';

class WalletRepository implements WalletInterface {
  final WalletDataProvider walletDataProvider;

  const WalletRepository(this.walletDataProvider);

  @override
  Future<AppResponse> getWalletTransactions(query) {
    return walletDataProvider.getWalletTransactions(query);
  }

  @override
  Future<AppResponse> makeBankTransfer(values) {
    return walletDataProvider.makeBankTransfer(values);
  }
}
