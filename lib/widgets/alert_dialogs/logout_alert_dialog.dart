import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/services/injection.dart';
import 'package:shoplo_client/features/auth/presentation/cubit/logout/logout_cubit.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';
import 'package:shoplo_client/widgets/app_button.dart';
import 'package:shoplo_client/widgets/app_button_outline.dart';

import '../../core/config/constants.dart';
import '../../core/routes/app_routes.dart';
import '../../resources/colors/colors.dart';
import '../../resources/images/images.dart';

class LogoutDialogBox extends StatefulWidget {
  const LogoutDialogBox({
    Key? key,
  }) : super(key: key);

  @override
  LogoutDialogBoxState createState() => LogoutDialogBoxState();
}

class LogoutDialogBoxState extends State<LogoutDialogBox> {
  File? image;
  List<XFile>? images = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding20),
      ),
      elevation: 0,
      backgroundColor: AppColors.white,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(Constants.padding20),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset(
                  AppImages.warning,
                  matchTextDirection: true,
                ),
                const SizedBox(height: 5),
                Text(
                  context.tr.logout_message,
                  style: AppTextStyle.textStyleMediumGold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BlocProvider(
                      create: (context) => LogoutCubit(),
                      child: BlocConsumer<LogoutCubit, LogoutState>(
                        listener: (context, state) {
                          if (state is LogoutSuccessState) {
                            Navigator.of(context).popUntil(
                              (route) =>
                                  route.settings.name == AppRoutes.appHome,
                            );
                            serviceLocator
                                .get<GlobalKey<ScaffoldState>>()
                                .currentState!
                                .closeDrawer();
                          }
                        },
                        builder: (context, state) {
                          return AppButton(
                            width: 100,
                            loading: state is LogoutLoadingState,
                            onPressed: () async {
                              // if (Platform.isIOS) {
                              //   exit(0);
                              // } else {
                              //   SystemNavigator.pop();
                              // }
                              LogoutCubit.get(context).logout();
                            },
                            title: context.tr.yes,
                          );
                        },
                      ),
                    ),
                    AppButtonOutline(
                        title: context.tr.cancel,
                        onPressed: () async {
                          Navigator.of(context).pop();
                        }),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
