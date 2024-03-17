import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/features/auth/presentation/cubit/forgot/forgot_cubit.dart';
import 'package:shoplo_client/resources/colors/colors.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';
import 'package:shoplo_client/widgets/app_snack_bar.dart';
import 'package:shoplo_client/widgets/form_field/phone_form_field.dart';

import '../../../../core/config/constants.dart';
import '../../../../resources/images/images.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/auth_title.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../widgets/logo.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String countryCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryL,
      appBar: AppBar(
        title: Text(context.tr.forget_password,style: AppTextStyle.textStyleMediumWhite,),
        backgroundColor: AppColors.primaryL,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            AppImages.back,
            color: AppColors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: NetworkSensitive(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.padding15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: context.height * .05,
                  ),
                  Center(
                    child: SvgPicture.asset(
                      AppImages.Forgotpass,
                      fit: BoxFit.contain,
                      width: context.width * .6,
                      height: context.width * .6,
                    ),
                  ),
                  SizedBox(
                    height: context.height * .07,
                  ),
                ],
              ),
              AuthTitle(
                  context.tr.forget_password, context.tr.text_forgetpassword),
              SizedBox(
                height: context.height * .01,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      PhoneTextFormField(
                        label: context.tr.phone_number,
                        controller: phone,
                        onSelect: (val) {
                          setState(() {
                            countryCode = val;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: context.height * .07,
              ),
              BlocProvider(
                create: (context) => ForgotCubit(),
                child: BlocConsumer<ForgotCubit, ForgotState>(
                  listener: (context, state) {
                    if (state is ForgetPasswordLoadedState) {
                      Navigator.of(context).pushNamed(
                          AppRoutes.verifyForgotPassword,
                          arguments: {
                            "phone": phone.text,
                            "countryCode": countryCode,
                          });
                    }
                    if (state is ForgetPasswordErrorState) {
                      if (state.statusCode == 425) {
                        Navigator.of(context).pushNamed(AppRoutes.verifyPhone,
                            arguments: {
                              "phone": phone.text,
                              "countryCode": countryCode
                            });
                      }
                      AppSnackBar.showError(state.error);
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      loading: state is ForgetPasswordLoadingState,
                      title: context.tr.done,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ForgotCubit.get(context).forgetPassword({
                            "phone": phone.text,
                            "country_code": countryCode,
                            "type": "client",
                            //"country_code": arguments[1],
                          });
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
