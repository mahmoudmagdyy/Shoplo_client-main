import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/config/constants.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/features/network/presentation/pages/network_sensitive.dart';

import '../../../../core/helpers/storage_helper.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_loading.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../data/models/cities_search.dart';
import '../cubit/cities/cities_cubit.dart';
import '../cubit/cities/cities_state.dart';

class Cities extends StatefulWidget {
  final String countryId;
  final String countryName;

  const Cities({Key? key, required this.countryId, required this.countryName})
      : super(key: key);

  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  final _searchController = TextEditingController();

  late CitiesSearch allCities;

  @override
  void initState() {
    super.initState();
    context.read<CitiesCubit>().getCities(widget.countryId);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryL,
      appBar: AppBar(
        title: Text(
          context.tr.city,
          style: AppTextStyle.textStyleBoldWhite,
        ),
        backgroundColor: AppColors.primaryL,
        elevation: 0,
        leading: InkWell(
          onTap: () {
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
        ),
      ),
      body: NetworkSensitive(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.padding20, vertical: Constants.padding5),
          child: BlocConsumer<CitiesCubit, CitiesState>(
            listener: (context, state) {
              if (state is GetCitiesLoadedState) {
                allCities = state.data;
              }
            },
            builder: (context, state) {
              if (state is GetCitiesLoadedState) {
                return Column(
                  children: [
                    SizedBox(
                      height: context.height * 0.03,
                    ),
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
                    SizedBox(
                      height: context.height * 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: context.tr.choose_city,
                              hintStyle: AppTextStyle.textStyleMediumGray15,
                              prefixIcon: SvgPicture.asset(
                                AppImages.arrowdown,
                                width: 16,
                                height: 16,
                                fit: BoxFit.scaleDown,
                              ),
                              suffixIcon: SvgPicture.asset(
                                AppImages.searchicon,
                                width: 16,
                                height: 16,
                                fit: BoxFit.scaleDown,
                              )),
                          controller: _searchController,
                          onChanged: (val) => context
                              .read<CitiesCubit>()
                              .getFilteredCities(val, allCities),
                        ),
                      ),
                      // TextField(
                      //   decoration: const InputDecoration(
                      //     prefixIcon: Icon(
                      //       Icons.search,
                      //       color: AppColors.primaryL,
                      //     ),
                      //   ),
                      //   controller: _searchController,
                      //   onChanged: (val) => context
                      //       .read<CitiesCubit>()
                      //       .getFilteredCities(val, allCities),
                      // ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.data.cities.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: GestureDetector(
                              onTap: () async {
                                StorageHelper.saveData(
                                  key: "selectedCity",
                                  value: state.data.cities[index].id,
                                );
                                StorageHelper.saveData(
                                  key: "cityName",
                                  value: state.data.cities[index].name,
                                );
                                StorageHelper.saveData(
                                  key: "countryName",
                                  value: widget.countryName,
                                );
                                context.read<UserCubit>().setUserLocation({
                                  'country': widget.countryName,
                                  'city': state.data.cities[index].name,
                                  'country_id': widget.countryId,
                                });

                                Navigator.pushNamed(
                                    context, AppRoutes.selectMainService);
                                // await showDialog(
                                //   // barrierColor: Colors.transparent,
                                //   context: context,
                                //   builder: (_) {
                                //     return SelectCategoryDialog(
                                //       onPressedYes: (String d) {},
                                //     );
                                //   },
                                // );
                              },
                              child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.primaryL,
                                    border: Border.all(
                                      color: AppColors.white,
                                      // Border color
                                      width: 2.0, // Border width
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      state.data.cities[index].name,
                                      style: AppTextStyle.textStyleWhiteMedium,
                                    ),
                                  )),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>  SizedBox(
                          height:context.height*0.001,

                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is GetCitiesLoadingState) {
                return const AppLoading(
                  color: AppColors.loadingColor,
                );
              } else if (state is GetCitiesErrorState) {
                return Center(
                  child: Text(state.error.toString()),
                );
              } else if (state is GetCitiesEmpty) {
                return Center(child: _emptyBuilder());
              } else {
                return const SizedBox();
              }
            },
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
