import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/resources/colors/colors.dart';
import 'package:shoplo_client/resources/images/images.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';

import '../../../../core/helpers/storage_helper.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../widgets/alert_dialogs/login_alert_dialog.dart';
import '../../../auth/presentation/cubit/cities/cities_cubit.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../cubit/home_cubit.dart';

class SelectMainService extends StatelessWidget {
  const SelectMainService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                child: Text.rich(TextSpan(
                  children: [
                    TextSpan(text: context.tr.what_is_on_your_mind),
                    TextSpan(text: " ${context.tr.the_best} ", style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: context.tr.for_you),
                  ],
                  style: AppTextStyle.textStylePrimaryColorSemiBold2
                )),
              ),
               SizedBox(
                height: context.height*0.1,
              ),

              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: context.width*0.05,
                clipBehavior: Clip.none,
                runSpacing: context.width*0.05,
                children: [
                  MainServiceItem(
                    title: context.tr.stores.toUpperCase(),
                    icon: AppImages.store,
                    backGroundColor:Color(0xffEEF7F1),
                    color: const Color(0xff82C69A),
                    onTap: () {
                      context.read<CitiesCubit>().setSelectedCategory("stores");
                      if (StorageHelper.getData(
                        key: "enteredBefore",
                      ) !=
                          null) {
                        HomeCubit.get(context).selectCategory(null);
                        Navigator.of(context).pushNamed(
                          AppRoutes.appHome,
                        );
                      } else {
                        HomeCubit.get(context).selectCategory(null);

                        Navigator.of(context).pushNamed(
                          AppRoutes.appHome,
                        );
                      }
                    },
                  ),
                  MainServiceItem(
                    title: context.tr.delivery_with_multiple_orders.toUpperCase(),
                    icon: AppImages.multidelivary,
                    backGroundColor:Color(0xffFEF6ED),
                    color: const Color(0xffF8A44C),
                    onTap: () {
                      if (UserCubit.get(context).userData == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => const LoginAlertDialog(),
                        );
                        return;
                      }
                      Navigator.of(context).pushNamed(
                        AppRoutes.multipleOrdersScreen,
                      );
                    },
                  ),
                  MainServiceItem(
                    title: context.tr.ship_by_global.toUpperCase(),
                    icon: AppImages.global,
                    backGroundColor:Color(0xffF4EBF7),
                    color: const Color(0xffD3B0E0),
                    onTap: () {
                      if (UserCubit.get(context).userData == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => const LoginAlertDialog(),
                        );
                        return;
                      }
                      Navigator.of(context).pushNamed(
                        AppRoutes.shipByGlobalScreen,
                      );
                    },
                  ),
                  MainServiceItem(
                    title: context.tr.global_delevery.toUpperCase(),
                    icon: AppImages.lo,
                    backGroundColor:Color(0xffF4EBF7),
                    color: const Color(0xffD3B0E0),
                    onTap: () {
                      if (UserCubit.get(context).userData == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => const LoginAlertDialog(),
                        );
                        return;
                      }
                      Navigator.of(context).pushNamed(
                        AppRoutes.shipByGlobalScreen,
                      );
                    },
                  ),
                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}

class MainServiceItem extends StatelessWidget {
  const MainServiceItem({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.backGroundColor,
    required this.onTap,
  });
  final String title;
  final String icon;
  final Color color;
  final Color backGroundColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:170,
      width: 170,
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.zero,
        color:backGroundColor,
        borderOnForeground: true,
        shape:  RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: color,
          ),
            borderRadius: BorderRadius.all( Radius.circular(20),)),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.transparent,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                child: Image.asset(
                  icon,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
