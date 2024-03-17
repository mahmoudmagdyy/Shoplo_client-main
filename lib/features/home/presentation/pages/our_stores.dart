import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/home/presentation/cubit/home_cubit.dart';
import 'package:shoplo_client/features/home/presentation/cubit/location_cubit.dart';

import '../../../../core/helpers/storage_helper.dart';
import '../../../../widgets/app_list.dart';
import '../../../../widgets/form_field/search_text_field.dart';
import '../../../auth/presentation/cubit/cities/cities_cubit.dart';
import '../cubit/stores_cubit.dart';
import '../widgets/new_store_widget.dart';

class OurStoresScreen extends HookWidget {
  const OurStoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<StoresCubit>().getStores({
        "is_paginated": "1",
        "type": 'stores',
        "city": StorageHelper.getData(key: "selectedCity"),
        "latitude": context.read<LocationCubit>().latLng.latitude,
        "longitude": context.read<LocationCubit>().latLng.longitude,
        "category_id": context.read<HomeCubit>().selectedCategoryId
      });
      return () {};
    }, [
      context.watch<CitiesCubit>().refreshHome,
    ]);

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
                SearchTextField(
                  hint: context.tr.search_your_favorite_store,
                  onChanged: (s) {
                    context.read<StoresCubit>().getStores({
                      "is_paginated": "1",
                      "type": 'stores',
                      "city": StorageHelper.getData(key: "selectedCity"),
                      "latitude": context.read<LocationCubit>().latLng.latitude,
                      "longitude": context.read<LocationCubit>().latLng.longitude,
                      "Searchwithtype": s.isEmpty ? '' : '$s,stores',
                      "category_id": context.read<HomeCubit>().selectedCategoryId,
                      "has_stores": 1
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: AppList(
                    key: const Key('OurStoresList'),
                    grid: false,
                    loadingMoreResults: context.watch<StoresCubit>().loadingMoreResults,
                    fetchPageData: (query) => context.read<StoresCubit>().getStores({
                      ...query,
                      "is_paginated": "1",
                      "type": 'stores',
                      "city": StorageHelper.getData(key: "selectedCity"),
                      // "latitude": context.read<LocationCubit>().latLng.latitude,
                      // "longitude": context.read<LocationCubit>().latLng.longitude,
                      "category_id": context.read<HomeCubit>().selectedCategoryId
                    }),
                    loadingListItems: state is GetStoresLoadingState,
                    hasReachedEndOfResults: context.watch<StoresCubit>().hasReachedEndOfResults,
                    endLoadingFirstTime: context.watch<StoresCubit>().endLoadingFirstTime,
                    itemBuilder: (context, index) {
                      return NewStoreWidget(
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
