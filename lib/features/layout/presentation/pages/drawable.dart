import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/config/constants.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/auth/presentation/cubit/cities/cities_cubit.dart';
import 'package:shoplo_client/features/layout/presentation/cubit/user/user_cubit.dart';
import 'package:shoplo_client/features/layout/presentation/widgets/drawer_item.dart';
import 'package:shoplo_client/resources/styles/app_sized_box.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/injection.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../widgets/alert_dialogs/delete_account_alert_dialog.dart';
import '../../../../widgets/alert_dialogs/logout_alert_dialog.dart';
import '../../../../widgets/shoplo/language_sheet.dart';

class DrawableWidget extends StatelessWidget {
  const DrawableWidget({super.key});

  showLogoutPickerDialog(context) {
    return showDialog(
      context: context,
      barrierColor: AppColors.primaryL.withOpacity(.5),
      builder: (BuildContext context) {
        return const LogoutDialogBox();
      },
    );
  }

  showDeleteAccountPickerDialog(context) {
    return showDialog(
      context: context,
      barrierColor: AppColors.primaryL.withOpacity(.5),
      builder: (BuildContext context) {
        return const DeleteAccountDialogBox();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String userImage = UserCubit.get(context).userData != null
        ? UserCubit.get(context).userData!.user.avatar
        : "https://cc-gs.com/shopLo-backend/public/assets/images/default/default.jpg"; //live
    // "https://shoplo.fudex-tech.net/shopLo-backend/public/assets/images/default/default.jpg";//demo
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.primaryL,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryL,
          // for Android
          statusBarIconBrightness: Brightness.light,
          // for IOS
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Drawer(
        backgroundColor: AppColors.white,
        width: context.width,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.8862502574920654, -0.6871650815010071),
              end: Alignment(-0.1467052847146988, 0.8862502574920654),
              colors: [
                AppColors.gradient_1,
                AppColors.gradient_2,
                AppColors.gradient_3,
                AppColors.gradient_4,
              ],
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(Constants.padding20),
                //   child: Row(
                //     children: [
                //       InkWell(
                //         child: SvgPicture.asset(AppImages.close),
                //         onTap: () {
                //           ScaffoldService.scaffoldKey.currentState!
                //               .closeDrawer();
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 10, 5),
                      child: CircleAvatar(
                        backgroundColor: AppColors.border,
                        radius: 40.0,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            backgroundColor: AppColors.white,
                            radius: 40.0,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: BlocConsumer<UserCubit, UserState>(
                                listener: (context, state) {
                                  if (state is SetUserData) {
                                    if (UserCubit.get(context).userData != null) {
                                      userImage = UserCubit.get(context).userData!.user.avatar;
                                    }
                                  }
                                },
                                builder: (context, state) {
                                  return CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                      userImage,
                                    ),
                                    radius: 40.0,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (UserCubit.get(context).userData != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr.user_name,
                            style: AppTextStyle.textStyleWhiteRegular13,
                          ),
                          Text(
                            UserCubit.get(context).userData != null ? UserCubit.get(context).userData!.user.name : "",
                            style: AppTextStyle.textStyleWhiteSemiBold19,
                          ),
                        ],
                      ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Constants.padding15),
                      child: InkWell(
                        child: SvgPicture.asset(AppImages.close),
                        onTap: () {
                          serviceLocator.get<GlobalKey<ScaffoldState>>().currentState!.closeDrawer();
                        },
                      ),
                    ),
                  ],
                ),
                AppSizedBox.sizedH10,
                if (UserCubit.get(context).userData != null)
                  DrawerItem(
                    title: context.tr.account,
                    iconName: AppImages.user,
                    routeName: AppRoutes.editAccount,
                  ),
                DrawerItem(
                  title: context.tr.stores,
                  iconName: AppImages.myOrders,
                  routeName: '',
                  onTap: () {
                    context.read<CitiesCubit>().setSelectedCategory('stores');
                    serviceLocator.get<GlobalKey<ScaffoldState>>().currentState!.closeDrawer();
                  },
                ),
                DrawerItem(
                  title: context.tr.delivery_with_multiple_orders,
                  iconName: AppImages.myOrders,
                  routeName: '',
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.multipleOrdersScreen,
                    );
                  },
                ),
                DrawerItem(
                  title: context.tr.ship_by_global,
                  iconName: AppImages.myOrders,
                  routeName: '',
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.shipByGlobalScreen,
                    );
                  },
                ),
                DrawerItem(
                  title: context.tr.ship_by_global_orders,
                  iconName: AppImages.myOrders,
                  routeName: '',
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.shipByGlobalList,
                    );
                  },
                ),
                if (UserCubit.get(context).userData != null)
                  DrawerItem(
                    title: context.tr.my_orders,
                    iconName: AppImages.myOrders,
                    routeName: AppRoutes.myOrder,
                  ),
                if (UserCubit.get(context).userData != null)
                  DrawerItem(
                    title: context.tr.my_addresses,
                    iconName: AppImages.myAddresses,
                    routeName: AppRoutes.addresses,
                  ),
                if (UserCubit.get(context).userData != null)
                  DrawerItem(
                    title: context.tr.wallet,
                    iconName: 'wallet',
                    iconIcon: Icons.account_balance_wallet_outlined,
                    routeName: AppRoutes.walletChargeScreen,
                  ),
                DrawerItem(
                  title: context.tr.contact_us,
                  iconName: AppImages.contactUs,
                  routeName: AppRoutes.contactUs,
                ),
                DrawerItem(
                  title: context.tr.about_us,
                  iconName: AppImages.faq,
                  routeName: AppRoutes.aboutUsScreen,
                ),
                DrawerItem(
                  title: context.tr.change_language,
                  iconName: AppImages.lang,
                  routeName: AppRoutes.introLanguage,
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          // <-- SEE HERE
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, setState) => const LanguageSheet(),
                          );
                        });
                  },
                ),
                DrawerItem(
                  title: context.tr.terms_and_conditions,
                  iconName: AppImages.faq,
                  routeName: AppRoutes.terms,
                ),
                DrawerItem(
                  title: context.tr.privacy,
                  iconName: AppImages.faq,
                  routeName: AppRoutes.privacy,
                ),
                if (UserCubit.get(context).userData != null)
                  DrawerItem(
                    title: context.tr.delete_account,
                    iconName: "delete_account",
                    iconIcon: Icons.delete_outline,
                    routeName: AppRoutes.privacy,
                    onTap: () {
                      showDeleteAccountPickerDialog(context);
                    },
                  ),

                SizedBox(
                  height: context.height * .05,
                ),
                UserCubit.get(context).userData != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Constants.padding15,
                        ),
                        child: InkWell(
                          onTap: () {
                            showLogoutPickerDialog(context);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppImages.logout,
                              ),
                              AppSizedBox.sizedW10,
                              Text(
                                context.tr.logout,
                                style: AppTextStyle.textStyleWhiteMedium,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Constants.padding15,
                        ),
                        child: InkWell(
                          onTap: () {
                            serviceLocator.get<GlobalKey<ScaffoldState>>().currentState!.closeDrawer();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.login,
                              (route) => false,
                              arguments: true,
                            );
                            // Navigator.of(context).popUntil(
                            //   (route) => route.settings.name == AppRoutes.login,
                            // );
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppImages.logout,
                              ),
                              AppSizedBox.sizedW10,
                              Text(
                                context.tr.login,
                                style: AppTextStyle.textStyleWhiteMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                SizedBox(
                  height: context.height * .05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
