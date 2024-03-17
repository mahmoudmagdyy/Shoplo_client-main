import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/widgets/app_snack_bar.dart';
import 'package:shoplo_client/widgets/app_toast.dart';
import '../../../../core/config/constants.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/auth_title.dart';
import '../../../../widgets/form_field/password_form_field.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../cubit/change_password/change_password_cubit.dart';
import '../widgets/logo.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appAppBar(context, context.tr.change_password),
      body: NetworkSensitive(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.padding15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LogoWidget(),
              AuthTitle(context.tr.change_password, context.tr.please_enter_new_password),
              SizedBox(
                height: context.height * .02,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      PasswordTextFormField(controller: oldPassword, label: context.tr.old_password),
                      SizedBox(height: context.height * .02),
                      PasswordTextFormField(controller: password, label: context.tr.password),
                      SizedBox(
                        height: context.height * .02,
                      ),
                      PasswordTextFormField(controller: confirmPassword, label: context.tr.confirm_password),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: context.height * .07,
              ),
              BlocProvider(
                create: (context) => ChangePasswordCubit(),
                child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                  listener: (context, state) {
                    if (state is ChangePasswordErrorState) {
                      AppSnackBar.showError(state.error);
                    }
                    if (state is ChangePasswordLoadedState) {
                      AppToast.showToastSuccess(state.data["message"]);
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      loading: state is ChangePasswordLoadingState,
                      title: context.tr.done,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ChangePasswordCubit.get(context).changePassword({
                            "old_password": oldPassword.text,
                            "new_password": password.text,
                            "new_password_confirmation": confirmPassword.text,
                            "type": "client",
                          }, UserCubit.get(context).userData!.accessToken);
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
