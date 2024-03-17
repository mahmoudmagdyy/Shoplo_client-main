import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';
import 'package:shoplo_client/widgets/form_field/phone_form_field.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../core/config/constants.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_loading.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../../domain/entities/contact_us_types.dart';
import '../cubit/contact_us_cubit.dart';


class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _form = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController message = TextEditingController();
  final TextEditingController title = TextEditingController();
  final _dropdownState = GlobalKey<FormFieldState>();

  String countryCode = "";
  @override
  void dispose() {
    // dispose the controller
    message.dispose();
    title.dispose();
    super.dispose();
  }

  @override
  void initState() {
    UserCubit appCubit = UserCubit.get(context);

    // if (appCubit.userData!.user != null) {
    //   // countryCode = appCubit.userData.user!.countryCode!;
    // }

    name.text = UserCubit.get(context).userData!=null? UserCubit.get(context).userData!.user.name:"";
    phone.text = UserCubit.get(context).userData!=null? UserCubit.get(context).userData!.user.phone:"";
    email.text = UserCubit.get(context).userData!=null? UserCubit.get(context).userData!.user.email:"";
    countryCode = UserCubit.get(context).userData!=null? UserCubit.get(context).userData!.user.countryCode:"";

    super.initState();

    ContactUsCubit.get(context).getContactUsTypes();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: appAppBar(context, context.tr.contact_us),
      body: NetworkSensitive(
        child: Form(
          key: _form,
          child: AutofillGroup(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(Constants.padding20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const HeightSpace(),
                      Center(
                        child: Image.asset(
                          AppImages.contactUS,
                          fit: BoxFit.contain,
                          width: context.width * .25,
                          height: context.width * .25,
                        ),
                      ),
                      const HeightSpace(),
                      Text(
                        context.tr.do_not_hesitate_to_contact_us,
                        style: AppTextStyle.textStyleMediumGold,
                      ),

                      AppTextFormField(label: context.tr.name, controller: name,),
                      const HeightSpace(),
                      AppTextFormField(label: context.tr.email, controller: email,),
                      const HeightSpace(),
                      PhoneTextFormField(
                        controller: phone,
                        baseCountryCode:countryCode,
                        onSelect: (val) {
                          setState(() {
                            countryCode = val;
                          });
                        },
                      ),

                      const HeightSpace(),
                      AppTextFormField(label: context.tr.title, controller: title,),
                      const HeightSpace(),
                      BlocBuilder<ContactUsCubit, ContactUsState>(
                        builder: (context, state) {
                          return DropdownButtonFormField<ContactUsTypesEntity>(
                            key: _dropdownState,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            items: ContactUsCubit.get(context).contactUsTypeList.map(buildMenuItem).toList(),
                            // value: cubit.complainType,
                            dropdownColor: AppColors.white,
                            style: AppTextStyle.textStyleEditTextValueRegularBlack,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.textAppGray, width: .5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.gray,
                              size: 25,
                            ),
                            hint: state is ContactUsTypesUsLoadingState ? const AppLoading(scale: .4, color: AppColors.primaryL,)
                                : Text(context.tr.type,style: AppTextStyle.textStyleRegularGray,),
                            // hint: Text(
                            //   AppLocalizations.of(context)!.choose_complaint_type,
                            //   style: const TextStyle(
                            //       color: AppColors.grey, fontSize: 14),
                            // ),
                            onChanged: (newVal) {
                              ContactUsCubit.get(context).setSelectedComplainType(newVal!);
                            },
                            validator: (value) {
                              if (value != null) {
                                return null;
                              } else {
                                return context.tr.required_field;
                              }
                            },
                          );
                        },
                      ),
                      const HeightSpace(),
                      AppTextFormField(label: context.tr.message, controller: message,maxLine: 7),

                      SizedBox(
                        height: context.height * .12,
                        child: Column(
                          children: [
                            Divider(
                              color: AppColors.grey.withOpacity(.1),
                              thickness: 3,
                              endIndent: 0,
                              indent: 0,
                            ),
                            const HeightSpace(),
                            BlocConsumer<ContactUsCubit, ContactUsState>(
                              listener: (context, state) async{
                                if (state is ContactUsErrorState) {
                                  AppSnackBar.showError(state.error);
                                }
                                if (state is ContactUsSuccessState)  {
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
                                        if(ContactUsCubit.get(context).complainType!=null){
                                          ContactUsCubit.get(context).sendContactUs({
                                            'name':name.text,
                                            'email':email.text,
                                            'phone':phone.text,
                                            'country_code':countryCode,
                                            'title': title.text,
                                            'body': message.text,
                                            'contact_type_id':ContactUsCubit.get(context).complainType!.id,
                                          });
                                        }
                                        else {
                                          Fluttertoast.showToast(
                                              msg: "This is Center Short Toast",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }
                                      }
                                    },
                                    title: context.tr.send,
                                  ),
                                );
                              },
                            ),
                            const HeightSpace(),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child:
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void whatsAppContact(String phone, String message) async {
    String urlToOpen = (Platform.isAndroid)
        ? "https://wa.me/$phone/?text=${Uri.parse(message)}" // new line
        : "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line

    await canLaunchUrlString(urlToOpen)
        ? await launchUrlString(urlToOpen)
        : throw 'Could not launch $urlToOpen';
  }

  DropdownMenuItem<ContactUsTypesEntity> buildMenuItem(ContactUsTypesEntity item) =>
      DropdownMenuItem(
        value: item,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
}


class HeightSpace extends StatelessWidget {
  const HeightSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * .01,
    );
  }
}
