import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoplo_client/core/config/constants.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:shoplo_client/features/network/presentation/pages/network_sensitive.dart';
import 'package:shoplo_client/resources/colors/colors.dart';
import 'package:shoplo_client/resources/images/images.dart';
import 'package:shoplo_client/widgets/app_button.dart';
import 'package:shoplo_client/widgets/app_snack_bar.dart';
import 'package:shoplo_client/widgets/app_toast.dart';
import 'package:shoplo_client/widgets/form_field/text_form_field.dart';

import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/form_field/password_form_field.dart';
import '../../../../widgets/form_field/phone_form_field.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';

import '../widgets/profileEmage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  String countryCode = '';
  String imageUrl = '';
  bool checkedValue = false;
  final _form = GlobalKey<FormState>();


  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryL,
      appBar:AppBar(
        backgroundColor: AppColors.primaryL,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(AppImages.back,color: AppColors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: NetworkSensitive(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Padding(
            padding: const EdgeInsets.all(Constants.padding15),
            child: Column(
              children: [
                ProfileImage(onSelect: (value) {
                  setState(() {
                    imageUrl = value;
                    print("imageUrl ==> ${imageUrl}");
                  });
                },),
                Form(
                  key: _form,
                  child: AutofillGroup(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppTextFormField(
                          title: context.tr.name,
                            controller: name, label: context.tr.name),
                        const HeightSpace(),
                        AppTextFormField(
                            title: context.tr.email,
                            controller: email, label: context.tr.email),
                        const HeightSpace(),
                        PhoneTextFormField(label:context.tr.phone_number,controller: phone, onSelect: (val) {
                          setState(() {
                            countryCode = val;
                          });
                        }),
                        const HeightSpace(),

                        PasswordTextFormField(

                          title: context.tr.password,
                          controller: password, label: context.tr.password,
                        ),
                        const HeightSpace(),
                        PasswordTextFormField(

                          title: context.tr.confirm_password,
                          controller: confirmPassword,
                          label: context.tr.confirm_password,
                        ),
                        const HeightSpace(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Checkbox(
                                value: checkedValue,
                                onChanged: (check) {
                                  setState(() {
                                    checkedValue = check!;
                                  });
                                }),
                            Flexible(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: context.tr.register_terms_info,
                                      style: AppTextStyle.textStyleRegularGray,
                                    ),
                                    TextSpan(
                                      text: context.tr.terms_and_conditions,
                                      style: AppTextStyle.textStyleRegularGold
                                          .copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context)
                                              .pushNamed(AppRoutes.terms);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const HeightSpace(),
                BlocProvider(
                  create: (context) => RegisterCubit(),
                  child: BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context,state){
                      if(state is RegisterLoadedState){
                        AppToast.showToastSuccess(state.RegisterData);
                        Navigator.of(context).pushNamed(AppRoutes.verifyPhone,arguments: {
                          "phone":phone.text,
                          "countryCode":countryCode
                        });
                      }
                      if(state is RegisterErrorState){
                        AppSnackBar.showError(state.error);
                      }
                    },
                    builder: (context, state) {
                      return AppButton(
                          loading: state is RegisterLoadingState,
                          onPressed: () {
                            if (checkedValue) {
                              if (_form.currentState!.validate()) {
                                RegisterCubit.get(context).register({
                                  "name": name.text,
                                  "phone": phone.text,
                                  "email": email.text,
                                  "password": password.text,
                                  "password_confirmation": confirmPassword.text,
                                  "country_code": countryCode,
                                  "confirmation": 1,
                                  "avatar": imageUrl,
                                });
                              }
                            }
                            else {
                              AppSnackBar.showError(context.tr.you_should_accept_terms);
                            }
                          },
                          title: context.tr.next_btn);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeightSpace extends StatelessWidget {
  const HeightSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * .02,
    );
  }
}
