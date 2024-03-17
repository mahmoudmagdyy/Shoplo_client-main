import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/auth/domain/entities/user.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';
import 'package:shoplo_client/widgets/app_button_outline.dart';
import 'package:shoplo_client/widgets/app_toast.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/helpers/dio_helper.dart';
import '../../../../core/helpers/storage_helper.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../../../widgets/auth_title.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../layout/domain/repositories/language.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../../data/models/user_data.dart';
import '../cubit/profile/profile_cubit.dart';
import '../cubit/verify_update_phone/verify_update_phone_cubit.dart';
import '../widgets/logo.dart';

class VerifyUpdatePhone extends StatefulWidget {
  final String phone;
  final String countryCode;

  const VerifyUpdatePhone({Key? key, required this.phone, required this.countryCode}) : super(key: key);

  @override
  _VerifyUpdatePhoneState createState() => _VerifyUpdatePhoneState();
}

class _VerifyUpdatePhoneState extends State<VerifyUpdatePhone> {
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
    return BlocProvider(
      create: (context) => VerifyUpdatePhoneCubit(),
      child: BlocConsumer<VerifyUpdatePhoneCubit, VerifyUpdatePhoneState>(
        listener: (context, state) {
          if (state is ResendUpdatePhoneErrorState) {
            AppSnackBar.showError(state.error);
          }
          if (state is ResendUpdatePhoneLoadedState) {
            AppSnackBar.showSuccess(state.data['message']);
          }

          if (state is VerifyUpdatePhoneErrorState) {
            AppSnackBar.showError(state.error);
          }
          if (state is VerifyUpdatePhoneLoadedState) {
            debugPrint('state222=====${state.verifyData.toString()}');
            AppToast.showToastSuccess(state.verifyData['message']);
            ProfileCubit.get(context).getProfile();
            Navigator.of(context).popUntil(
              (route) => route.settings.name == AppRoutes.editAccount,
            );
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //   AppRoutes.appHome,
            //       (route) => false,
            //   arguments: true,
            // );
          }
          if (state is VerifyUpdatePhoneUserLoadedState) {
            debugPrint('state=====${state.verifyData.user.toString()}');
            AppSnackBar.showSuccess(context.tr.account_verified);
            String initLanguage = LanguageRepository.initLanguage();
            DioHelper.init(lang: initLanguage, accessToken: state.verifyData.accessToken);
            UserCubit.get(context).setUser(UserDataModel(user: state.verifyData.user, accessToken: state.verifyData.accessToken));
            StorageHelper.saveObject(
              key: 'userData',
              object: UserDataModel(
                accessToken: state.verifyData.accessToken,
                user: User(
                  id: state.verifyData.user.id,
                  name: state.verifyData.user.name,
                  email: state.verifyData.user.email,
                  phone: state.verifyData.user.phone,
                  avatar: state.verifyData.user.avatar,
                  isActive: state.verifyData.user.isActive,
                  addresses: state.verifyData.user.addresses,
                  countryCode: state.verifyData.user.countryCode,
                  createdAt: state.verifyData.user.createdAt,
                  gender: state.verifyData.user.gender,
                  lastLoginAt: state.verifyData.user.lastLoginAt,
                  type: state.verifyData.user.type,
                  wallet: state.verifyData.user.wallet,
                  verificationCode: state.verifyData.user.verificationCode,
                ),
              ),
            );
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //   AppRoutes.appHome,
            //       (route) => false,
            //   arguments: true,
            // );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: appAppBar(context, context.tr.verify_phone_number, onPress: () {
              Navigator.of(context).popUntil(
                (route) => route.settings.name == AppRoutes.editAccount,
              );
            }),
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
                  (route) => route.settings.name == AppRoutes.editAccount,
                );
                return false;
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(Constants.padding15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LogoWidget(),
                      AuthTitle(context.tr.verify_phone_number, context.tr.verification_details + widget.phone),
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
                              fieldOuterPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 3),
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
                              if (isNumeric(v)) {
                                setState(() {
                                  // isVerified = true;
                                  currentText = v;
                                });
                                if (state is VerifyUpdatePhoneLoadingState) {
                                  return;
                                }
                                VerifyUpdatePhoneCubit.get(context).verifyCode({
                                  "country_code": widget.countryCode,
                                  "phone": widget.phone,
                                  "code": currentText,
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

                      // if (state is VerifyUpdatePhoneLoadingState)
                      //   const AppLoading(
                      //     color: AppColors.primaryL,
                      //   ),
                      SizedBox(
                        height: context.height * .05,
                      ),
                      AppButton(
                        loading: state is VerifyUpdatePhoneLoadingState,
                        title: context.tr.confirm,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            VerifyUpdatePhoneCubit.get(context).verifyCode({
                              "country_code": widget.countryCode,
                              "phone": widget.phone,
                              "code": currentText,
                              "type": "client",
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: context.height * .02,
                      ),
                      AppButtonOutline(
                          title: context.tr.resend_code,
                          loading: state is ResendUpdatePhoneLoadingState,
                          onPressed: () {
                            if (state is ResendUpdatePhoneLoadingState) return;
                            VerifyUpdatePhoneCubit.get(context).resendCode({
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
