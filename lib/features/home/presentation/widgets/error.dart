import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_error.dart';
import '../cubit/location_cubit.dart';

class HomeErrorWidget extends StatefulWidget {
  final String message;

  const HomeErrorWidget({super.key, required this.message});

  @override
  State<HomeErrorWidget> createState() => _HomeErrorWidgetState();
}

class _HomeErrorWidgetState extends State<HomeErrorWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      LocationCubit locationCubit = LocationCubit.get(context);
      locationCubit.getCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppError(error: context.tr.location_has_been_denied),
          const SizedBox(height: 20),
          AppButton(
            title: context.tr.open_location_settings,
            onPressed: () async {
              await Geolocator.openAppSettings();
            },
          ),
        ],
      ),
    );
  }
}
