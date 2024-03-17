import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/home/presentation/pages/map.dart';

import '../cubit/location_cubit.dart';

class OtherStoresScreen extends HookWidget {
  const OtherStoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.other_stores),
      ),
      body: MapWidget(
        latLng: context.read<LocationCubit>().latLng,
        type: 'store',
      ),
    );
    // return Container(
    //   margin: const EdgeInsets.symmetric(horizontal: 10),
    //   padding: const EdgeInsets.only(top: 15),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   child: BlocBuilder<MapCubit, MapState>(
    //     builder: (context, state) {
    //       return AppList(
    //         key: const Key('OthersStoresList'),
    //         grid: true,
    //         numberOfColumn: 2,
    //         childAspectRatio: 0.5,
    //         loadingMoreResults: context.watch<MapCubit>().loadingMoreResults,
    //         fetchPageData: (query) => context.read<MapCubit>().getGoogleStores({
    //           ...query,
    //           'radius': '2000',
    //           'location':
    //               '${context.read<LocationCubit>().latLng.latitude},${context.read<LocationCubit>().latLng.longitude}',
    //           'language': context.read<AppCubit>().getCurrentLanguage(context),
    //           "country": context.read<CountryCubit>().selectedCountry!.id,
    //           "type": 'store',
    //         }),
    //         loadingListItems: state is GetStoresLoadingState,
    //         hasReachedEndOfResults:
    //             context.watch<MapCubit>().hasReachedEndOfResults,
    //         endLoadingFirstTime: context.watch<MapCubit>().endLoadingFirstTime,
    //         itemBuilder: (context, index) {
    //           return GoogleStorWidget(
    //             store: context.watch<MapCubit>().googleStores[index],
    //           );
    //         },
    //         listItems: context.watch<MapCubit>().googleStores,
    //       );
    //     },
    //   ),
    // );
  }
}
