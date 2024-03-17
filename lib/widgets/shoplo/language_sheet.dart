import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../core/helpers/dio_helper.dart';
import '../../core/helpers/storage_helper.dart';
import '../../core/routes/app_routes.dart';
import '../../features/layout/domain/entities/language.dart';
import '../../features/layout/domain/repositories/language.dart';
import '../../features/layout/presentation/cubit/app/app_cubit.dart';
import '../../features/layout/presentation/cubit/user/user_cubit.dart';
import '../../resources/colors/colors.dart';
import '../../resources/images/images.dart';
import '../../resources/styles/app_text_style.dart';
import '../app_button.dart';

class LanguageSheet extends StatefulWidget {
  final bool isIntro;

  const LanguageSheet({Key? key, this.isIntro = false}) : super(key: key);

  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<LanguageSheet> {
  Language? _lang;

  @override
  void initState() {
    super.initState();
    if (StorageHelper.getData(key: 'lang') == "ar") {
      _lang = Language.arabic;
    } else {
      _lang = Language.english;
    }
  }
  var selected;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: context.height * 0.1,
          ),
          Text(
            context.tr.choselanguage,
            style: AppTextStyle.textStyleBoldWhite,
          ),
          SizedBox(
            height: context.height * 0.1,
          ),
          InkWell(
            onTap: () {
              setState(() {
                 selected=IsSelected.select1;
                _lang = Language.arabic;
                print(_lang);
              });
            },
            child: Container(
              width: context.width * 0.9,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: selected==IsSelected.select1 ? AppColors.white : AppColors.primaryL,
                border: Border.all(
                  color: selected==IsSelected.select1 ? AppColors.secondaryL : AppColors.white,
                  // Border color
                  width: 2.0, // Border width
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        context.tr.arabic,
                        style: selected==IsSelected.select1
                            ? AppTextStyle.textStyleMediumGray2
                            : AppTextStyle.textStyleMediumWhite,
                      ),
                    ),
                    const CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage(AppImages.ar),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: context.height * 0.03,
          ),
          InkWell(
            onTap: () {
              setState(() {
                selected=IsSelected.select2;
                _lang = Language.english;
                print(_lang);
              });
            },
            child: Container(
              width: context.width * 0.9,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: selected==IsSelected.select2 ? AppColors.white : AppColors.primaryL,
                border: Border.all(
                  color: selected==IsSelected.select2 ? AppColors.secondaryL : AppColors.white,
                  // Border color
                  width: 2.0, // Border width
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        context.tr.english,
                        style: selected==IsSelected.select2
                            ? AppTextStyle.textStyleMediumGray2
                            : AppTextStyle.textStyleMediumWhite,
                      ),
                    ),
                    const CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage(AppImages.Flageng),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       context.tr.english,
          //       style: AppTextStyle.textStyleMediumGray,
          //     ),
          //
          //     // Radio<Language>(
          //     //   value: Language.english,
          //     //   groupValue: _lang,
          //     //   onChanged: (Language? value) {
          //     //     setState(() {
          //     //       _lang = value;
          //     //     });
          //     //   },
          //     // ),
          //   ],
          // ),
          Spacer(),
          AppButton(
            title: context.tr.done,
            onPressed: () {
              AppCubit.get(context)
                  .setLang(Locale(_lang == Language.arabic ? "ar" : "en"));
              LanguageRepository.setLangData(
                  _lang == Language.arabic ? "ar" : "en");
              DioHelper.init(
                lang: _lang == Language.arabic ? "ar" : "en",
                accessToken: UserCubit.get(context).userData != null
                    ? UserCubit.get(context).userData!.accessToken.toString()
                    : '',
              );
              if (widget.isIntro) {
                Navigator.pushNamed(context, AppRoutes.onBoardingRoute);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          SizedBox(
            height: context.height * 0.05,
          ),
        ],
      ),
    );
  }
}
