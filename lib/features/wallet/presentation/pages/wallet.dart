import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/widgets/shoplo/app_app_bar.dart';

import '../../../../core/services/pusher_service.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_list.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../cubit/wallet_cubit.dart';
import '../widgets/wallet.dart';

class WalletScreen extends HookWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      initializeWalletPusher(context);
      return () {
        onDisconnectWalletPusher();
      };
    }, []);

    return Scaffold(
      appBar: appAppBar(context, context.tr.wallet),
      body: NetworkSensitive(
        child: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            WalletCubit cubit = WalletCubit.get(context);

            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                if (state is WalletSuccessState)
                  Text(
                    state.total,
                    style: const TextStyle(
                      color: AppColors.primaryL,
                      fontSize: 28,
                      height: .5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  context.tr.transactions_on_wallet,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: AppList(
                      physics: const AlwaysScrollableScrollPhysics(),
                      key: const Key('WalletList'),
                      fetchPageData: (query) => cubit.getWallet(query),
                      loadingListItems: state is WalletLoadingState,
                      hasReachedEndOfResults: cubit.hasReachedEndOfResults,
                      endLoadingFirstTime: cubit.endLoadingFirstTime,
                      loadingMoreResults: cubit.loadingMoreResults,
                      itemBuilder: (context, index) => WalletWidget(
                        transaction: cubit.wallet[index],
                      ),
                      listItems: cubit.wallet,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
