import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';
import 'package:shoplo_client/widgets/app_button_outline.dart';

import '../../../../core/config/constants.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/auth_title.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../widgets/logo.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  // bool isVerified = false;
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String currentText = '';
  String code = '';

  // @override
  // void dispose() {
  //   _textController.dispose(); // dispose the controller
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
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        UserCubit cubit = UserCubit.get(context);

        // if (state is ResendErrorState) {
        //   AppSnackBar.showError(state.error);
        // }
        // if (state is ResendLoadedState) {
        //   AppSnackBar.showSuccess(state.data['message']);
        // }

        // if (state is VerifyErrorState) {
        //   AppSnackBar.showError(state.error);
        // }
        // if (state is VerifyLoadedState) {
        //   debugPrint('state222=====${state.verifyData.toString()}');
        //   AppSnackBar.showSuccess(state.verifyData['message']);
        //   Navigator.of(context).pushNamedAndRemoveUntil(
        //     AppRoutes.appHome,
        //         (route) => false,
        //     arguments: true,
        //   );
        // }
        // if (state is VerifyUserLoadedState) {
        //   debugPrint('state=====${state.verifyData.user.toString()}');
        //   AppSnackBar.showSuccess(context.tr.account_verified);
        //   if (arguments[2] == AppRoutes.appHome) {
        //     //AppSnackBar.showSuccess(context.tr.account_verified);
        //     String initLanguage = LanguageRepository.initLanguage();
        //     DioHelper.init(
        //         lang: initLanguage,
        //         accessToken: state.verifyData.accessToken as String);
        //     cubit.setUser(UserDataModel(
        //         user: state.verifyData.user,
        //         accessToken: state.verifyData.accessToken));
        //     StorageHelper.saveObject(
        //       key: 'userData',
        //       object: UserDataModel(
        //         accessToken: state.verifyData.accessToken,
        //         user: UserModel(
        //           id: state.verifyData.user!.id,
        //           name: state.verifyData.user!.name,
        //           email: state.verifyData.user!.email,
        //           phone: state.verifyData.user!.phone,
        //           avatar: state.verifyData.user!.avatar,
        //           isActive: state.verifyData.user!.isActive,
        //           salary: state.verifyData.user!.salary,
        //           job: state.verifyData.user!.job,
        //         ),
        //       ),
        //     );
        //     AppCubit.get(context).onItemTapped(0);
        //     Navigator.of(context).pushNamedAndRemoveUntil(
        //       AppRoutes.appHome,
        //           (route) => false,
        //       arguments: true,
        //     );
        //   }
        // }
      },
      builder: (context, state) {
        UserCubit cubit = UserCubit.get(context);

        return Scaffold(
          appBar: appAppBar(context, ''),
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
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Constants.padding15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LogoWidget(),
                  AuthTitle(context.tr.confirm_mail,
                      "Enter the 4-digit code send to(ramy@mail.com)"),
                  SizedBox(
                    height: context.height * .01,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Form(
                      key: _formKey,
                      child: PinCodeTextField(
                        length: 4,
                        controller: _textController,
                        cursorColor: AppColors.primaryL,
                        textStyle: AppTextStyle.textStyleMediumPrimary,
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
                          activeColor: AppColors.primaryL,
                          inactiveFillColor: AppColors.white,
                        ),
                        backgroundColor: Colors.transparent,
                        animationDuration: const Duration(milliseconds: 300),
                        onChanged: (value) {
                          setState(() {
                            currentText = value;
                          });
                        },
                        onCompleted: (v) {
                          // if (isNumeric(v)) {
                          //   setState(() {
                          //     // isVerified = true;
                          //     currentText = v;
                          //   });
                          //   if (state is VerifyLoadingState) return;
                          //   cubit.verifyCode({
                          //     "phone": arguments[0],
                          //     "code": currentText,
                          //     //"country_code": arguments[1],
                          //   }, "");
                          //   // Navigator.of(context)
                          //   //     .pushNamed(AppRoutes.resetPasswordScreen);
                          // }
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
                   // loading: state is VerifyLoadingState,
                    title: context.tr.confirm,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // cubit.VerifyEmail({
                        //   "phone": arguments[0],
                        //   "code": currentText,
                        //   //"country_code": arguments[1],
                        // }, "");
                      }
                      //Navigator.of(context).pushNamed(AppRoutes.userTypeScreen);
                    },
                  ),
                  SizedBox(
                    height: context.height * .02,
                  ),
                  AppButtonOutline(
                      title: context.tr.resend_code,
                      onPressed: () {
                       // if (state is ResendLoadingState) return;
                        // cubit.resendCode({
                        //   "phone": arguments[0],
                        //   // "code": currentText,
                        //   //"country_code": arguments[1],
                        // });
                        debugPrint("asdasdasdasd");
                      }),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
