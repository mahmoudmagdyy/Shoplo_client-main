

import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/resources/colors/colors.dart';
import 'package:shoplo_client/widgets/app_button.dart';
import 'package:lottie/lottie.dart';

import '../../../../resources/styles/app_text_style.dart';

class DoneResetPassword extends StatelessWidget {
  const DoneResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.primaryL,
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 30),
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: context.height*0.06),
            Lottie.asset("assets/images/Animation - 1708947099248 (1).json",width: 200,height: 200,),
            SizedBox(height: context.height*0.06),
          const Center(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "تم تغيير كلمة المرور!",
                textAlign: TextAlign.center,
                style:AppTextStyle.textStylegoldRegular33,
              ),
              SizedBox(height: 10),
              Text(
                "تم تغيير كلمة المرور الخاصة بك بنجاح.",
                style: AppTextStyle.textStyleWhiteSemiBold19,
              ),
            ],
                  ),
          ),
            const Spacer(),
        AppButton(onPressed:(){
          Navigator.pushNamed(context, AppRoutes.login);
        },  title: "done")
          ],
        )),
      ),
    );
  }
}
