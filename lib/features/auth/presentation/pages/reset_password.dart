import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/features/auth/presentation/cubit/reset/reset_password_cubit.dart';
import 'package:shoplo_client/resources/colors/colors.dart';
import 'package:shoplo_client/widgets/app_snack_bar.dart';
import 'package:shoplo_client/widgets/app_toast.dart';

import '../../../../core/config/constants.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/auth_title.dart';
import '../../../../widgets/form_field/password_form_field.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../widgets/logo.dart';

class ResetPassword extends StatefulWidget {
  final String countryCode;
  final String phone;
  final String token;
  const ResetPassword({Key? key, required this.countryCode, required this.phone, required this.token}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryL,
      appBar:  AppBar(
        title: Text(
          context.tr.change_password,
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
      body: NetworkSensitive(
          child: Padding(
            padding: const EdgeInsets.all(Constants.padding15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(
                  height: context.height * .06,
                ),
                // const LogoWidget(),
                AuthTitle(context.tr.change_password,
                    context.tr.please_enter_new_password),
                SizedBox(
                  height: context.height * .06,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        PasswordTextFormField(
                            controller: password, label: context.tr.password),
                        SizedBox(
                          height: context.height * .02,
                        ),
                        PasswordTextFormField(
                            controller: confirmPassword,
                            label: context.tr.confirm_password),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: context.height * .07,
                ),
                BlocProvider(
                  create: (context) => ResetPasswordCubit(),
                  child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                    listener: (context, state) {
                    if(state is ResetPasswordErrorState){
                      AppSnackBar.showError(state.error);
                    }
                    if(state is ResetPasswordLoadedState){
                      AppToast.showToastSuccess(state.data["message"]);
                      Navigator.of(context).pushNamed(AppRoutes.login);
                    }
                    },
                    builder: (context, state) {
                      return AppButton(
                        loading: state is ResetPasswordLoadingState,
                        title: context.tr.done,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                           ResetPasswordCubit.get(context).resetPassword(
                             {
                               "phone":widget.phone,
                               "country_code":widget.countryCode,
                               "token":widget.token,
                               "password":password.text,
                               "password_confirmation":confirmPassword.text,
                               "type":"client",
                             }
                           );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
