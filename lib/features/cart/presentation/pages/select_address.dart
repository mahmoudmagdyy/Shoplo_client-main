import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:shoplo_client/widgets/index.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../widgets/select_address.dart';

class SelectAddressesScreen extends StatelessWidget {
  const SelectAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appAppBar(context, context.tr.my_addresses),
      appBar: appAppBar(
        context,
        context.tr.my_addresses,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.addAddress);
            },
            child: Text(
              context.tr.add_address,
            ),
          ),
        ],
      ),
      body: BlocBuilder<AddressesCubit, AddressesState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppList(
              key: const Key('addressesList'),
              fetchPageData: (query) =>
                  AddressesCubit.get(context).getAddresses(),
              loadingListItems: state is GetAddressesLoadingState,
              loadingMoreResults:
                  AddressesCubit.get(context).loadingMoreResults,
              hasReachedEndOfResults: true,
              endLoadingFirstTime:
                  AddressesCubit.get(context).endLoadingFirstTime,
              itemBuilder: (context, index) {
                return SelectAddressWidget(
                  address: AddressesCubit.get(context).addresses[index],
                );
              },
              listItems: AddressesCubit.get(context).addresses,
            ),
          );
        },
      ),
    );
  }
}
