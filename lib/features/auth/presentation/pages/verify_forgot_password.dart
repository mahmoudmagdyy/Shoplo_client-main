import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/auth/presentation/cubit/verify/verify_account_cubit.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';
import 'package:shoplo_client/widgets/app_button_outline.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/helpers/dio_helper.dart';
import '../../../../core/helpers/storage_helper.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../../../widgets/auth_title.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../layout/domain/repositories/language.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../../data/models/user_data.dart';
import '../../domain/entities/user_data.dart';
import '../cubit/forgot/verify_forgot_password_cubit.dart';
import '../widgets/logo.dart';

class VerifyForgotPassword extends StatefulWidget {
  final String phone;
  final String countryCode;

  const VerifyForgotPassword(
      {Key? key, required this.phone, required this.countryCode})
      : super(key: key);

  @override
  _VerifyForgotPasswordState createState() => _VerifyForgotPasswordState();
}

class _VerifyForgotPasswordState extends State<VerifyForgotPassword> {
  // bool isVerified = false;
  final TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String currentText = '';
  String code = '';

  // @override
  // void dispose() {
  //   textController.dispose(); // dispose the controller
  //   super.dispose();
  // }

  // int counter = 0;
  bool isNumeric(String s) {
    if (s.isEmpty) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    // final List arguments = ModalRoute.of(context)!.settings.arguments as List;
    var width = context.width;
    return BlocProvider(
      create: (context) => VerifyForgotPasswordCubit(),
      child: BlocConsumer<VerifyForgotPasswordCubit, VerifyForgotPasswordState>(
        listener: (context, state) {
          // if (state is ResendResetErrorState) {
          //   AppSnackBar.showError(state.error);
          // }
          // if (state is ResendResetLoadedState) {
          //   AppSnackBar.showSuccess(state.data['message']);
          // }
          //
          // if (state is VerifyTokenErrorState) {
          //   AppSnackBar.showError(state.error);
          // }
          // if (state is VerifyTokenLoadedState) {
          //   debugPrint('state222=====${state.verifyData.toString()}');
          //   //AppSnackBar.showSuccess(state.verifyData['message']);
          //   Navigator.of(context)
          //       .pushNamed(AppRoutes.resetPassword, arguments: {
          //     "phone": widget.phone,
          //     "countryCode": widget.countryCode,
          //     "token": currentText,
          //   });
          // }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.primaryL,
            appBar: AppBar(
              title: Text(
                context.tr.verify_phone_number,
                style: AppTextStyle.textStyleMediumWhite,
              ),
              backgroundColor: AppColors.primaryL,
              elevation: 0,
              leading: IconButton(
                icon: SvgPicture.asset(
                  AppImages.back,
                  color: AppColors.white,
                ),
                onPressed: () => Navigator.of(context).popUntil(
                  (route) => route.settings.name == AppRoutes.login,
                ),
              ),
              automaticallyImplyLeading: false,
              forceMaterialTransparency: true,
            ),

            // appBar: AppBar(
            //   centerTitle: true,
            //   title: Text(
            //     context.tr.verify_phone_number,
            //   ),
            //   leading: BackButton(
            //     onPressed: () {
            //       Navigator.of(context).popUntil(
            //         (route) => route.settings.name == AppRoutes.login,
            //       );
            //     },
            //   ),
            // ),
            resizeToAvoidBottomInset: false,
            body: NetworkSensitive(
                child: WillPopScope(
              onWillPop: () async {
                Navigator.of(context).popUntil(
                  (route) => route.settings.name == AppRoutes.login,
                );
                return false;
              },
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
                            child: Image.asset(
                              AppImages.pngdone,
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
                      AuthTitle(context.tr.verify_phone_number,
                          context.tr.verification_details + widget.phone),
                      SizedBox(
                        height: context.height * .01,
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Form(
                          key: _formKey,
                          child: PinCodeTextField(
                            length: 4,
                            controller: textController,
                            cursorColor: AppColors.primaryL,
                            textStyle: AppTextStyle.textStyleWhiteRegular16,
                            keyboardType: TextInputType.number,
                            animationType: AnimationType.fade,
                            //enableActiveFill: true,
                            pinTheme: PinTheme(
                              fieldOuterPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 3),
                              fieldWidth: width * .18,
                              activeFillColor: AppColors.white,
                              inactiveColor: AppColors.textAppGray,
                              //disabledColor: AppColors.red,
                              selectedFillColor: AppColors.white,
                              selectedColor: AppColors.textAppGray,
                              errorBorderColor: AppColors.white,
                              activeColor: AppColors.white,
                              inactiveFillColor: AppColors.white,
                            ),
                            backgroundColor: Colors.transparent,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            onChanged: (value) {
                              setState(() {
                                currentText = value;
                              });
                            },
                            onCompleted: (v) {
                              if (isNumeric(v)) {
                                setState(() {
                                  // isVerified = true;
                                  currentText = v;
                                });
                                if (state is VerifyLoadingState) return;
                                VerifyForgotPasswordCubit.get(context)
                                    .verifyToken({
                                  "country_code": widget.countryCode,
                                  "phone": widget.phone,
                                  "token": currentText,
                                  "type": "client",
                                });
                                // Navigator.of(context)
                                //     .pushNamed(AppRoutes.resetPasswordScreen);
                              }
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              return true;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return context.tr.required_field;
                              } else {
                                if (value.length != 4) {
                                  return context.tr.required_field;
                                } else {
                                  if (isNumeric(value)) {
                                    return null;
                                  } else {
                                    return context.tr.enter_valid_number;
                                  }
                                }
                              }
                            },
                            appContext: context,
                          ),
                        ),
                      ),

                      // if (state is VerifyLoadingState)
                      //   const AppLoading(
                      //     color: AppColors.primaryL,
                      //   ),
                      SizedBox(
                        height: context.height * .05,
                      ),
                      AppButton(
                        loading: state is VerifyTokenLoadingState,
                        title: context.tr.confirm,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.resetPassword, arguments: {
                            "phone": widget.phone,
                            "countryCode": widget.countryCode,
                            "token": currentText,
                          });
                          // if (_formKey.currentState!.validate()) {
                          //   VerifyForgotPasswordCubit.get(context).verifyToken({
                          //     "country_code": widget.countryCode,
                          //     "phone": widget.phone,
                          //     "token": currentText,
                          //     "type": "client",
                          //   });
                          // }
                        },
                      ),
                      SizedBox(
                        height: context.height * .02,
                      ),
                      AppButtonOutline(
                          title: context.tr.resend_code,
                          loading: state is ResendResetLoadingState,
                          onPressed: () {
                            if (state is ResendResetLoadingState) return;
                            VerifyForgotPasswordCubit.get(context).resendCode({
                              "country_code": widget.countryCode,
                              "phone": widget.phone,
                              "type": "client",
                            });
                          }),
                    ],
                  ),
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
