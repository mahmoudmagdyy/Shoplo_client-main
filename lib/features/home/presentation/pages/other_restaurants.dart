import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../cubit/location_cubit.dart';
import 'map.dart';

class OtherRestaurantsScreen extends HookWidget {
  const OtherRestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    return MapWidget(
      latLng: context.read<LocationCubit>().latLng,
      type: 'restaurant',
    );
  }
}
