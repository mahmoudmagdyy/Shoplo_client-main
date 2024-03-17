import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';

import '../../../../core/config/constants.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/auth_title.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../widgets/logo.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appAppBar(context, context.tr.change_email),
      body: NetworkSensitive(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.padding15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LogoWidget(),
              AuthTitle(
                  context.tr.change_email, context.tr.change_email_details),
              SizedBox(
                height: context.height * .02,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextFormField(
                        controller: email,
                        label: context.tr.email,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: context.height * .07,
              ),
              AppButton(
                loading: /*state is VerifyLoadingState*/ false,
                title: context.tr.done,
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   // cubit.VerifyPhone({
                  //   //   "phone": arguments[0],
                  //   //   "code": currentText,
                  //   //   //"country_code": arguments[1],
                  //   // }, "");
                  // }

                  Navigator.of(context).pushNamed(AppRoutes.verifyEmail);
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
