import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/app_loading.dart';
import '../cubit/internet_cubit.dart';
import '../widgets/no_internet.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;

  const NetworkSensitive({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //   child: BlocBuilder<ConnectionCheckerCubit, ConnectionCheckerState>(
    //     builder: (context, state) {
    //       if (state is InternetConnectionDisconnected) {
    //         return const NoInterNetConnection();
    //       } else if (state is InternetConnectionConnected) {
    //         return child;
    //       } else {
    //         return const AppLoading(color: Colors.red);
    //       }
    //     },
    //   ),
    // );
    return SafeArea(
      child: BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
        builder: (context, state) {
          if (state is InternetDisconnected) {
            return const NoInterNetConnection();
          } else if (state is InternetConnectionSuccessState) {
            return child;
          } else {
            return const AppLoading(color: Colors.red);
          }
        },
      ),
    );
  }
}
