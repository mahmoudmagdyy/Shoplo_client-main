import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/resources/colors/colors.dart';

import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../widgets/complete.dart';
import '../widgets/in_progress.dart';
import '../widgets/rejected.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.tr.my_order,
            style: AppTextStyle.textStyleAppBar,
          ),
          elevation: 3,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.white,
            // for Android
            statusBarIconBrightness: Brightness.dark,
            // for IOS
            statusBarBrightness: Brightness.light,
          ),
          // actions: [
          //   Padding(
          //     padding:
          //     const EdgeInsets.symmetric(horizontal: Constants.padding15),
          //     child: SvgPicture.asset(AppImages.search),
          //   ),
          // ],
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(context.width * .045),
              child: SvgPicture.asset(
                AppImages.back,
                matchTextDirection: true,
              ),
            ),
          ),
          bottom: TabBar(
            indicatorColor: AppColors.textBlack,
            tabs: <Widget>[
              Tab(
                text: context.tr.in_progress,
              ),
              Tab(
                text: context.tr.complete,
              ),
              Tab(
                text: context.tr.rejected,
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            InProgress(),
            Complete(),
            Rejected(),
          ],
        ),
      ),
    );
  }
}
