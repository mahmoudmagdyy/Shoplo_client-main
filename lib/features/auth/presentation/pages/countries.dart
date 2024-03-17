import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoplo_client/core/config/constants.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/auth/presentation/cubit/country/country_cubit.dart';
import 'package:shoplo_client/features/network/presentation/pages/network_sensitive.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../widgets/app_loading.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';

class Countries extends StatefulWidget {
  const Countries({Key? key}) : super(key: key);

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<CountryCubit>().getCountries(all: true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryL,
        appBar: AppBar(
          title: Text(
            context.tr.country,
            style: AppTextStyle.textStyleBoldWhite,
          ),
          backgroundColor: AppColors.primaryL,
          elevation: 0,
          leading:InkWell(
            onTap:() {
                  Navigator.pop(context);
                },
            child: Padding(
              padding: EdgeInsets.all(context.width * .045),
              child: SvgPicture.asset(
                AppImages.back,
                color: AppColors.white,
                matchTextDirection: true,
              ),
            ),
          ) ,
        ),
        body: NetworkSensitive(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.padding20, vertical: Constants.padding5),
            child: Column(
              children: [
                SizedBox(height: context.height*0.03,),
                SizedBox(
                  child: Center(
                    child: Image.asset(
                      width: 200,
                      height: 100,
                      AppImages.logoglobal,
                      matchTextDirection: true,
                    ),
                  ),
                ),
                SizedBox(height: context.height*0.1,),
                BlocBuilder<CountryCubit, CountryState>(
                  builder: (context, state) {
                    if (state is GetCountriesLoadedState) {
                      if (state.data.isEmpty) {
                        return _emptyBuilder();
                      }
                      return Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextField(
                                decoration:  InputDecoration(
                                  hintText: context.tr.choose_country,
                                  hintStyle: AppTextStyle.textStyleMediumGray15,
                                  prefixIcon: SvgPicture.asset(
                                    AppImages.arrowdown,
                                    width: 16,
                                    height: 16,
                                    fit:BoxFit.scaleDown,
                                  ),
                                  suffixIcon: SvgPicture.asset(
                                    AppImages.searchicon,
                                    width: 16,
                                    height: 16,
                                    fit:BoxFit.scaleDown,
                                  )

                                ),
                                controller: _searchController,
                                onChanged: (val) => context
                                    .read<CountryCubit>()
                                    .getFilteredCountries(val),
                              ),
                            ),
                            SizedBox(height: context.height*0.03,),
                            Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.data.length,
                                itemBuilder: (context, index) {
                                  return CountryItem(index, state.data);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is GetCountriesLoadingState) {
                      return const AppLoading(
                        color: AppColors.loadingColor,
                      );
                    } else if (state is GetCountriesErrorState) {
                      return Center(
                        child: Text(state.error.toString()),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emptyBuilder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.tr.no_data),
        ],
      ),
    );
  }
}

class CountryItem extends StatelessWidget {
  const CountryItem(
    this.index,
    this.data, {
    super.key,
  });

  final int index;
  final List data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pushNamed(AppRoutes.cities, arguments: {
          'countryId': data[index].id.toString(),
          'countryName': data[index].name
        });
      },
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: context.width * 0.9,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:  AppColors.white,
            border: Border.all(
              color:  AppColors.white,
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
                    data[index].name,
                    style: AppTextStyle.textStylePrimaryColorSemiBold,
                  ),
                ),
                 CircleAvatar(
                  radius: 15,
                  child: CachedNetworkImage(
                    imageUrl: data[index].flag,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                    const AppLoading(color: AppColors.primaryL),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 1),
                              blurRadius: 1,
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      //
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       CircleAvatar(
      //         radius: 40,
      //         child: CachedNetworkImage(
      //           imageUrl: data[index].flag,
      //           fit: BoxFit.cover,
      //           placeholder: (context, url) =>
      //               const AppLoading(color: AppColors.primaryL),
      //           errorWidget: (context, url, error) => const Icon(Icons.error),
      //           imageBuilder: (context, imageProvider) => Container(
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(40),
      //                 image: DecorationImage(
      //                   image: imageProvider,
      //                   fit: BoxFit.cover,
      //                 ),
      //                 boxShadow: const [
      //                   BoxShadow(
      //                     color: Colors.black,
      //                     offset: Offset(0, 1),
      //                     blurRadius: 1,
      //                   ),
      //                 ]),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 5,
      //       ),
      //       Center(
      //         child: Text(
      //           data[index].name,
      //           textAlign: TextAlign.center,
      //           style: AppTextStyle.textStyleWhiteRegular13,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
