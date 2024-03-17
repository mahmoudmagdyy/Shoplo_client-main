import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/helpers/storage_helper.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_list.dart';
import '../../../auth/presentation/cubit/cities/cities_cubit.dart';
import '../cubit/location_cubit.dart';
import '../cubit/stores_cubit.dart';
import '../widgets/store_widget.dart';

class OurRestaurantsScreen extends HookWidget {
  const OurRestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer? debounce;
    onSearchChanged(String query) {
      if (debounce?.isActive ?? false) debounce?.cancel();
      debounce = Timer(const Duration(milliseconds: 800), () {
        context.read<StoresCubit>().getStores({
          "is_paginated": "1",
          "type": 'stores',
          "city": StorageHelper.getData(key: "selectedCity"),
          "latitude": context.read<LocationCubit>().latLng.latitude,
          "longitude": context.read<LocationCubit>().latLng.longitude,
          "Searchwithtype": query.isEmpty ? '' : '$query,restaurants',
        });
      });
    }

    useEffect(() {
      context.read<StoresCubit>().getStores({
        "is_paginated": "1",
        "type": 'restaurants',
        "city": StorageHelper.getData(key: "selectedCity"),
        "latitude": context.read<LocationCubit>().latLng.latitude,
        "longitude": context.read<LocationCubit>().latLng.longitude,
      });
      return null;
    }, [context.watch<CitiesCubit>().refreshHome]);

    useAutomaticKeepAlive(wantKeepAlive: true);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: BlocBuilder<StoresCubit, StoresState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: onSearchChanged,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.primaryL,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: AppList(
                    key: const Key('OurRestaurantsList'),
                    grid: true,
                    childAspectRatio: 0.6,
                    loadingMoreResults:
                        context.watch<StoresCubit>().loadingMoreResults,
                    fetchPageData: (query) =>
                        context.read<StoresCubit>().getStores({
                      ...query,
                      "is_paginated": "1",
                      "type": 'restaurants',
                      "city": StorageHelper.getData(key: "selectedCity"),
                      "latitude": context.read<LocationCubit>().latLng.latitude,
                      "longitude":
                          context.read<LocationCubit>().latLng.longitude,
                    }),
                    loadingListItems: state is GetStoresLoadingState,
                    hasReachedEndOfResults:
                        context.watch<StoresCubit>().hasReachedEndOfResults,
                    endLoadingFirstTime:
                        context.watch<StoresCubit>().endLoadingFirstTime,
                    itemBuilder: (context, index) {
                      return StorWidget(
                        store: context.watch<StoresCubit>().stores[index],
                      );
                    },
                    listItems: context.watch<StoresCubit>().stores,
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
