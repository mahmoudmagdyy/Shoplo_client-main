import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shoplo_client/core/config/constants.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:shoplo_client/resources/images/images.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';
import 'package:shoplo_client/widgets/app_snack_bar.dart';

import '../../../../core/helpers/dio_helper.dart';
import '../../../../core/helpers/storage_helper.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/auth_title.dart';
import '../../../../widgets/form_field/password_form_field.dart';
import '../../../../widgets/form_field/phone_form_field.dart';
import '../../../layout/domain/repositories/language.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../../data/models/user_data.dart';
import '../../domain/entities/user.dart';
import '../widgets/logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _form = GlobalKey<FormState>();
  String countryCode = '';
  bool checkBoxValue = false;
  bool _value = false;

  @override
  void dispose() {
    phone.dispose(); // dispose the controller
    password.dispose(); // dispose the controller
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
          return false;
        } else {
          return false;
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backintros),
            fit: BoxFit.cover,
          ),),
        child: Scaffold(
          backgroundColor: AppColors.primaryL,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: AppColors.primaryL,
            elevation: 0,
            forceMaterialTransparency: true,
            automaticallyImplyLeading: false,
          ),
          body: NetworkSensitive(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Constants.padding15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LogoWidget(),
                    // AuthTitle(
                    //   AppLocalizations.of(context)!.login,
                    //   AppLocalizations.of(context)!.welcome_login,
                    // ),
                    SizedBox(
                      height: context.height * .02,
                    ),
                    Form(
                      key: _form,
                      child: AutofillGroup(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            PhoneTextFormField(
                                controller: phone,
                                onSelect: (val) {
                                  setState(() {
                                    countryCode = val;
                                    debugPrint("country code call back function $countryCode");
                                  });
                                }),
                            SizedBox(
                              height: context.height * .02,
                            ),
                            PasswordTextFormField(
                              controller: password,
                              label: context.tr.password,
                            ),
                            SizedBox(),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: _value,
                                    onChanged: (value) {
                                      _value = value!;
                                      setState(() {});
                                    },
                                  ),
                                  Text(
                                    context.tr.remember_me,
                                    style: AppTextStyle.textStyleMediumGray,
                                  ),
                                  Spacer(),
                                  Text(
                                    AppLocalizations.of(context)!.forget_password,
                                    style: AppTextStyle.textStyleMediumGray,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                   SizedBox(
                     height: context.height*0.08,
                   ),
                    BlocProvider(
                      create: (context) => LoginCubit(),
                      child: BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginLoadedState) {
                            // AppSnackBar.showError(context.tr.success );

                            debugPrint('user=====${state.loginData}');
                            debugPrint('token=====${state.accessToken}');

                            if (!state.loginData.isActive) {
                              AppSnackBar.showError(AppLocalizations.of(context)!.user_inactive);
                            } else if (state.loginData.isActive) {
                              String initLanguage = LanguageRepository.initLanguage();
                              DioHelper.init(lang: initLanguage, accessToken: state.accessToken);
                              //to check remember me
                              UserCubit.get(context).setUser(
                                UserDataModel(
                                  accessToken: state.accessToken,
                                  user: User(
                                    id: state.loginData.id,
                                    name: state.loginData.name,
                                    email: state.loginData.email,
                                    phone: state.loginData.phone,
                                    avatar: state.loginData.avatar,
                                    isActive: state.loginData.isActive,
                                    addresses: state.loginData.addresses,
                                    countryCode: state.loginData.countryCode,
                                    createdAt: state.loginData.createdAt,
                                    gender: state.loginData.gender,
                                    lastLoginAt: state.loginData.lastLoginAt,
                                    type: state.loginData.type,
                                    verificationCode: state.loginData.verificationCode,
                                    wallet: state.loginData.wallet,
                                  ),
                                ),
                              );
                              // if (checkBoxValue) {
                              StorageHelper.saveObject(
                                key: 'userData',
                                object: UserDataModel(
                                  accessToken: state.accessToken,
                                  user: User(
                                    id: state.loginData.id,
                                    name: state.loginData.name,
                                    email: state.loginData.email,
                                    phone: state.loginData.phone,
                                    avatar: state.loginData.avatar,
                                    isActive: state.loginData.isActive,
                                    addresses: state.loginData.addresses,
                                    countryCode: state.loginData.countryCode,
                                    createdAt: state.loginData.createdAt,
                                    gender: state.loginData.gender,
                                    lastLoginAt: state.loginData.lastLoginAt,
                                    type: state.loginData.type,
                                    wallet: state.loginData.wallet,
                                    verificationCode: state.loginData.verificationCode,
                                  ),
                                ),
                              );
                              // }
                              //NotificationsCountCubit cubit = NotificationsCountCubit.get(context);
                              //cubit.getNotificationsCount();

                              Navigator.of(context).pushNamedAndRemoveUntil(
                                AppRoutes.layout,
                                (route) => false,
                                arguments: true,
                              );
                              // Navigator.of(context).pushNamed(AppRoutes.countries);
                            }
                          }
                          if (state is LoginErrorState) {
                            if (state.statusCode == 425) {
                              Navigator.of(context).pushNamed(AppRoutes.verifyPhone, arguments: {"phone": phone.text, "countryCode": countryCode});
                            }
                            AppSnackBar.showError(state.error);
                          }
                        },
                        builder: (context, state) {
                          return AppButton(
                            loading: state is LoginLoadingState,
                            title: AppLocalizations.of(context)!.login,
                            onPressed: () {
                              if (_form.currentState!.validate()) {
                                LoginCubit.get(context).login({
                                  "country_code": countryCode,
                                  "phone": phone.text,
                                  "password": password.text,
                                  "type": "client",
                                });
                              }
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Constants.padding10),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.do_not_have_account_q,
                          style: AppTextStyle.textStyleMediumGray,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.register);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.register,
                            style: AppTextStyle.textStyleSemiBoldSecondary,
                          ),
                        ),
                      ]),
                    ),
                    // Center(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         width: context.width * .3,
                    //         height: .5,
                    //         color: AppColors.textGray,
                    //       ),
                    //       Text(" ${context.tr.or} ", style: AppTextStyle.textStyleRegularGray),
                    //       Container(
                    //         width: context.width * .3,
                    //         height: .5,
                    //         color: AppColors.textGray,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Center(
                    //   child: TextButton(
                    //     onPressed: () {
                    //       Navigator.of(context).pushNamed(AppRoutes.countries);
                    //       // Navigator.of(context).pushNamedAndRemoveUntil(
                    //       //   AppRoutes.countries,
                    //       //   (route) => false,
                    //       //   arguments: true,
                    //       // );
                    //     },
                    //     child: Text(
                    //       context.tr.skip,
                    //       style: AppTextStyle.textStyleRegularPrimary,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
