import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/config/constants.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/features/network/presentation/pages/network_sensitive.dart';
import 'package:shoplo_client/widgets/app_button.dart';
import 'package:shoplo_client/widgets/app_loading.dart';
import 'package:shoplo_client/widgets/app_snack_bar.dart';
import 'package:shoplo_client/widgets/app_toast.dart';
import 'package:shoplo_client/widgets/form_field/text_form_field.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/form_field/password_form_field.dart';
import '../../../../widgets/form_field/phone_form_field.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../cubit/profile/profile_cubit.dart';
import '../widgets/profileEmage.dart';

class ProfileAccount extends StatefulWidget {
  const ProfileAccount({Key? key}) : super(key: key);

  @override
  State<ProfileAccount> createState() => _ProfileAccountState();
}

class _ProfileAccountState extends State<ProfileAccount> {
  final _form = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool checkedValue = false;
  String countryCode = "";
  String profileImage = "";

  @override
  void initState() {
    super.initState();
    ProfileCubit.get(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryL,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(context.tr.edit_account,style: AppTextStyle.textStyleMediumWhite,),
        backgroundColor: AppColors.primaryL,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            AppImages.back,
            color: AppColors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: NetworkSensitive(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is GetProfileLoadedState) {
              name.text = state.useEntity.name;
              email.text = state.useEntity.email;
              phone.text = state.useEntity.phone;
              profileImage = state.useEntity.avatar;
              countryCode = state.useEntity.countryCode;
              password.text = context.tr.password;
            }
            if (state is UpdateProfileLoadedState) {
              AppToast.showToastSuccess(context.tr.sent_successfully);
              Navigator.of(context).pop();
            }
            if (state is GetProfileErrorState) {
              AppSnackBar.showError(state.error);
            }
            if (state is UpdateProfileErrorState) {
              AppSnackBar.showError(state.error);
            }
          },
          builder: (context, state) {
            if (state is GetProfileLoadingState) {
              return const AppLoading();
            } else {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(Constants.padding15),
                      child: Column(
                        children: [
                          ProfileImage(
                              profileImage: profileImage,
                              onSelect: (val) {
                                setState(() {
                                  profileImage = val;
                                });
                              }),
                          Form(
                            key: _form,
                            child: AutofillGroup(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  AppTextFormField(
                                    title:context.tr.name,
                                    controller: name,
                                    label:  "",
                                  ),
                                  const HeightSpace(),
                                  AppTextFormField(
                                    title:context.tr.email,
                                    readOnly: false,
                                    controller: email,
                                    label: "",
                                    edit: false,
                                    // onPress: () {
                                    //   Navigator.of(context).pushNamed(AppRoutes.changeEmail);
                                    // },
                                  ),
                                  const HeightSpace(),
                                  PhoneTextFormField(
                                    label:context.tr.phone_number,
                                    readOnly: true,
                                    controller: phone,
                                    edit: true,
                                    baseCountryCode: countryCode,
                                    onPress: () {
                                      Navigator.of(context)
                                          .pushNamed(AppRoutes.changePhone);
                                    },
                                    onSelect: (val) {
                                      setState(() {
                                        countryCode = val;
                                      });
                                    },
                                  ),
                                  const HeightSpace(),
                                  PasswordTextFormField(
                                    title: context.tr.password,
                                    readOnly: true,
                                    controller: password,
                                    label: "",
                                    edit: true,
                                    onPress: () {
                                      Navigator.of(context)
                                          .pushNamed(AppRoutes.changePassword);
                                    },
                                  ),
                                  SizedBox(
                                    height: context.height * .04,
                                  ), Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: AppButton(
                                        loading: state is UpdateProfileLoadingState,
                                        onPressed: () {
                                          debugPrint(
                                              "avatar - profileImage==> $profileImage");
                                          debugPrint(
                                              "accessToken22==> ${UserCubit.get(context).userData!.accessToken}");
                                          ProfileCubit.get(context).updateProfile(
                                              {
                                                "name": name.text,
                                                "avatar": profileImage,
                                                "email": email.text,
                                                "phone": phone.text,
                                                "country_code": countryCode,
                                                "_method": "put",
                                              },
                                              UserCubit.get(context)
                                                  .userData!
                                                  .accessToken);
                                        },
                                        title: context.tr.save),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              );
            }
          },
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
