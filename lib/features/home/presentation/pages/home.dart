import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/features/home/presentation/pages/new_home.dart';
import 'package:shoplo_client/features/layout/presentation/cubit/user/user_cubit.dart';

import '../../../../core/helpers/storage_helper.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_loading.dart';
import '../../../auth/presentation/cubit/cities/cities_cubit.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../cubit/location_cubit.dart';
import '../widgets/error.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<LocationCubit>().getCurrentLocation();
      context
          .read<CitiesCubit>()
          .setSelectedCategory(StorageHelper.getData(key: "selectedCategory"));
      return null;
    }, [
      context.watch<UserCubit>().userData,
      context.watch<CitiesCubit>(),
      context.watch<LocationCubit>()
    ]);

    return Scaffold(
      body: NetworkSensitive(
        child: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            if (state is GetCurrentLocationLoadingState) {
              return const AppLoading();
            } else if (state is GetCurrentLocationErrorState) {
              return HomeErrorWidget(message: state.error);
            } else if (state is ServiceEnabledErrorState) {
              return HomeErrorWidget(message: state.error);
            } else if (state is GetCurrentLocationSuccessState) {
              return const NewHomeScreen();
              // return MapWidget(
              //   latLng: LocationCubit.get(context).latLng,
              // );
            } else {
              return Container(
                color: AppColors.primaryL.withOpacity(.4),
              );
            }
          },
        ),
      ),
    );
  }
}
