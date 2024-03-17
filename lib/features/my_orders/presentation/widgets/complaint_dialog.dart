import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../core/config/constants.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../../../app_pages/presentation/cubit/contact_us_cubit.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';

class ComplaintDialog extends StatefulWidget {
  const ComplaintDialog({Key? key}) : super(key: key);

  @override
  State<ComplaintDialog> createState() => _ComplaintDialogState();
}

class _ComplaintDialogState extends State<ComplaintDialog> {
  final _form = GlobalKey<FormState>();
  final TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: context.width,
        height: context.height * .4,
        padding: EdgeInsets.all(context.width * .05),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0), bottom: Radius.circular(25.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.tr.make_complaint,
              style: AppTextStyle.textStyleMediumBlack,
            ),
            Form(
              key: _form,
                child: Column(
              children: [
                AppTextFormField(
                    label: context.tr.message, controller: message, maxLine: 7),
              ],
            )),
            BlocProvider(
              create: (context) => ContactUsCubit(),
              child: BlocConsumer<ContactUsCubit, ContactUsState>(
                listener: (context, state) async {
                  if (state is ContactUsErrorState) {
                    AppSnackBar.showError(state.error);
                  }
                  if (state is ContactUsSuccessState) {
                    AppSnackBar.showSuccess(context.tr.sent_successfully);
                    Future.delayed(const Duration(seconds: 1)).then((value) {
                      Navigator.of(context).pop();
                    });
                    // _formKey.currentState!.reset();
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Constants.padding15),
                    child: AppButton(
                      loading: state is ContactUsLoadingState,
                      onPressed: () {
                        if (_form.currentState!.validate()) {
                          // AppCubit appCubit = AppCubit.get(context);
                          ContactUsCubit.get(context).sendContactUs({
                            'name': UserCubit.get(context).userData != null ? UserCubit.get(context).userData!.user.name : "",
                            'email': UserCubit.get(context).userData != null ? UserCubit.get(context).userData!.user.email : "",
                            'phone': UserCubit.get(context).userData != null ? UserCubit.get(context).userData!.user.phone : "",
                            'country_code': UserCubit.get(context).userData != null ? UserCubit.get(context).userData!.user.countryCode : "",
                            'body': message.text,
                            'contact_type_id': 1,
                          });
                        }
                      },
                      title: context.tr.send,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
