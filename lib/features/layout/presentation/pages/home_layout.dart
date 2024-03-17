import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoplo_client/features/layout/presentation/pages/drawable.dart';

import '../../../../core/helpers/storage_helper.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/injection.dart';
import '../../../../core/services/push_notification_service.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../widgets/alert_dialogs/login_alert_dialog.dart';
import '../../../../widgets/alert_dialogs/logout_alert_dialog.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/pages/home.dart';
import '../../../notification/presentation/cubit/notifications_count_cubit.dart';
import '../cubit/user/user_cubit.dart';

class HomeLayout extends StatefulWidget {
  final bool inApp;

  const HomeLayout({
    Key? key,
    required this.inApp,
  }) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int notificationCount = 0;
  bool closeApp = false;

  @override
  void initState() {
    super.initState();
    StorageHelper.saveData(
      key: "enteredBefore",
      value: true,
    );
    //initDynamicLinks();
    // initUniLinks();
    UserCubit cubit = UserCubit.get(context);
    if (widget.inApp) {
      debugPrint('INAPP: ${widget.inApp.toString()}', wrapWidth: 1024);
    } else {
      if (cubit.userData != null) {
        debugPrint('INAPP 2222222: ${widget.inApp.toString()}', wrapWidth: 1024);
        // CartCubit cartCubit = CartCubit.get(context);
        // cartCubit.getCart({});
        NotificationsCountCubit.get(context).getNotificationsCount();
       // initializePushNotificationService(context);
      }
    }
  }


  @override
  Future<void> dispose() async {
    if (widget.inApp) {
      debugPrint('INAPP dispose: ${widget.inApp.toString()}', wrapWidth: 1024);
    } else {
      debugPrint('DISPOSE: ${'dispose'}', wrapWidth: 1024);
      // AwesomeNotifications().createdSink.close();
      // AwesomeNotifications().displayedSink.close();
      // AwesomeNotifications().actionSink.close();
      super.dispose();
      debugPrint('DISPOSE: ${'dispose11111'}', wrapWidth: 1024);
      await AwesomeNotifications().dispose();
      debugPrint('DISPOSE: ${'dispose22222'}', wrapWidth: 1024);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final cubit = HomeCubit.get(context);
        final cateId = cubit.selectedCategoryId;
        if (cateId != null) {
          cubit.selectCategory(null);
          return false;
        }
        if (Platform.isAndroid) {
          SystemNavigator.pop();
          return false;
        } else {
          return false;
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {},
          child: InkWell(
            onTap: () {
              if (UserCubit.get(context).userData != null) {
                Navigator.of(context).pushNamed(AppRoutes.cartScreen);
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const LoginAlertDialog(),
                );
              }
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    AppImages.shoppingCart,
                    width: 30,
                    height: 30,
                  ),
                ),
                if (UserCubit.get(context).userData != null)
                  Positioned(
                    top: -5,
                    right: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        border: Border.all(
                          color: Colors.red,
                        ),
                      ),
                      child: BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              CartCubit.get(context).cartCount.toString(),
                              style: const TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        key: serviceLocator.get<GlobalKey<ScaffoldState>>(),
        appBar: AppBar(
          leadingWidth: 40,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  IconButton(
                    splashRadius: null,
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.countries, arguments: "newState");
                    },
                    icon: SvgPicture.asset(
                      AppImages.editLocation,
                      width: 18,
                    ),
                  )
                ],
              ),
              Expanded(
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is SetUserLocation) {
                      return Row(
                        children: [
                          Text('${state.location['country']} , ', style: const TextStyle(fontSize: 14)),
                          Expanded(
                            child: Text('${state.location['city']}', style: const TextStyle(fontSize: 14)),
                          )
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          Text('${StorageHelper.getData(key: 'countryName')}', style: const TextStyle(fontSize: 14)),
                          Expanded(
                            child: Text('${StorageHelper.getData(key: 'cityName')}', style: const TextStyle(fontSize: 14)),
                          )
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          centerTitle: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.white,
            // for Android
            statusBarIconBrightness: Brightness.dark,
            // for IOS
            statusBarBrightness: Brightness.light,
          ),
          leading: IconButton(
            onPressed: () {
              serviceLocator.get<GlobalKey<ScaffoldState>>().currentState!.openDrawer();
            },
            icon: SvgPicture.asset(
              AppImages.menu,
              matchTextDirection: true,
            ),
          ),
          actions: [
            if (UserCubit.get(context).userData != null)
              Stack(
                children: [
                  InkWell(
                    child: Padding(padding: const EdgeInsets.all(10.0), child: Center(child: Image.asset(AppImages.notification, width: 15))),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.notification);
                    },
                  ),
                  BlocBuilder<NotificationsCountCubit, NotificationsCountState>(
                    builder: (context, state) {
                      NotificationsCountCubit cubit = NotificationsCountCubit.get(context);
                      if (cubit.notificationsCount == 0) {
                        return Positioned.directional(
                          textDirection: Directionality.of(context),
                          top: 14,
                          end: 6,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor: AppColors.red,
                            child: Text(
                                // cubit.notificationsCount > 99
                                //     ? '99+'
                                //     :
                                cubit.notificationsCount.toString(),
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 7,
                                )),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
          ],
        ),
        body: const HomeScreen(),
        drawer: const DrawableWidget(),
      ),
    );
  }

  showLogoutPickerDialog() {
    return showDialog(
      context: context,
      barrierColor: AppColors.primaryL.withOpacity(.5),
      builder: (BuildContext context) {
        return const LogoutDialogBox();
      },
    );
  }
}
