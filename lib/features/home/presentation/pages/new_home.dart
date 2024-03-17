import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/features/home/presentation/cubit/home_cubit.dart';
import 'package:shoplo_client/features/home/presentation/pages/stores_categories.dart';

import '../../../auth/presentation/cubit/cities/cities_cubit.dart';
import 'stores.dart';

class NewHomeScreen extends HookWidget {
  const NewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      debugPrint(
          "🚀 ~ file: ~ NewHomeScreen ~ ~ ${context.read<CitiesCubit>().selectedCategory}");
      // context.read<MapCubit>().clearGoogleStores();
      return null;
    }, [context.watch<CitiesCubit>().refreshHome]);

    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      print(state);
      return HomeCubit.get(context).selectedCategoryId == null
          ? const StoreCategories()
          : const StoresScreen();
    });
    // return DefaultTabController(
    //   initialIndex: 0,
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       toolbarHeight: 0,
    //       bottom: TabBar(
    //         indicatorColor: AppColors.primaryL,
    //         indicator: BoxDecoration(
    //           border: Border.all(
    //             width: 2,
    //             color: AppColors.primaryL,
    //           ),
    //           borderRadius: const BorderRadius.all(
    //             Radius.circular(10),
    //           ),
    //         ),
    //         indicatorWeight: 0,
    //         indicatorSize: TabBarIndicatorSize.label,
    //         // indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
    //         labelColor: AppColors.primaryL,
    //         labelStyle: const TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 16,
    //         ),
    //         tabs: <Widget>[
    //           Tab(
    //             text: '    ${context.tr.our_stores}    ',
    //           ),
    //           Tab(
    //             text: '    ${context.tr.other_stores}    ',
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: const TabBarView(
    //       children: <Widget>[
    //         StoresScreen(),
    //         OtherStoresScreen(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
