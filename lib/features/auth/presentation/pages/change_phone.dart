import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/widgets/form_field/phone_form_field.dart';

import '../../../../core/config/constants.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/auth_title.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../cubit/profile/profile_cubit.dart';
import '../widgets/logo.dart';

class ChangePhone extends StatefulWidget {
  const ChangePhone({Key? key}) : super(key: key);

  @override
  State<ChangePhone> createState() => _ChangePhoneState();
}

class _ChangePhoneState extends State<ChangePhone> {
  final TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String countryCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appAppBar(context, context.tr.change_phone),
      body: NetworkSensitive(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.padding15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LogoWidget(),
              AuthTitle(context.tr.change_phone, context.tr.enter_the_phone),
              SizedBox(
                height: context.height * .02,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      PhoneTextFormField(
                        controller: phone,
                        onSelect: (val) {
                          debugPrint("abcdefg $val");
                          countryCode = val;
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: context.height * .07,
              ),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if(state is UpdateProfileLoadedPhoneEditedState){
                    Navigator.of(context).pushNamed(AppRoutes.verifyUpdatePhone,arguments: {
                      "phone":phone.text,
                      "countryCode": countryCode,
                    });
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    loading: state is UpdateProfileLoadingState,
                    title: context.tr.done,
                    onPressed: () {
                      ProfileCubit.get(context).updateProfile({
                        "phone": phone.text,
                        "country_code": countryCode,
                        "_method": "put",
                      }, UserCubit.get(context).userData!.accessToken);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
