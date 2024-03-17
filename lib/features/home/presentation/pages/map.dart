import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';

import '../../../../core/helpers/storage_helper.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../widgets/app_error.dart';
import '../../../../widgets/app_loading.dart';
import '../../../../widgets/form_field/search_text_field.dart';
import '../../../layout/presentation/cubit/app/app_cubit.dart';
import '../../data/models/place_details.dart';
import '../cubit/location_cubit.dart';
import '../cubit/map_cubit.dart';
import '../widgets/google_store_widget.dart';

class MapWidget extends StatefulWidget {
  final LatLng latLng;
  final String type;

  const MapWidget({
    super.key,
    required this.latLng,
    required this.type,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> mapController = Completer();
  final Set<Marker> _markers = <Marker>{};
  late BitmapDescriptor marker1;
  late BitmapDescriptor marker2;
  final CarouselController carouselController = CarouselController();
  bool isVisible = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setMapIcons();
    _setLocations();
  }

  // deactivated
  @override
  deactivate() {
    super.deactivate();
  }

  Future<void> _setLocations() async {
    await Future.delayed(const Duration(seconds: 2));
    await setLocations(widget.latLng);
  }

  Future<void> _setMapIcons() async {
    if (Platform.isIOS) {
      await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(6, 6)), AppImages.iconMap1)
          .then((icon) {
        debugPrint('finish icon ===== ');
        marker1 = icon;
      });
      await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(6, 6)), AppImages.iconMap2)
          .then((icon) {
        debugPrint('finish icon ===== ');
        marker2 = icon;
      });
    } else {
      await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(6, 6)), AppImages.marker1)
          .then((icon) {
        debugPrint('finish icon ===== ');
        marker1 = icon;
      });
      await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(10, 10)), AppImages.marker2)
          .then((icon) {
        debugPrint('finish icon ===== ');
        marker2 = icon;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Stack(
        children: [
          buildMap(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: SizedBox(
              width: double.infinity,
              height: 140,
              child: googleStoresList(),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SearchTextField(
                hint: context.tr.search_your_favorite_store,
                controller: _searchController,
                onChanged: (s) {
                  _setLocations();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  PlaceDetails? selectedPlace;

  Widget googleStoresList() {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) {
        log("asdasdasdasd$state");
        MapCubit cubit = MapCubit.get(context);
        if (state is ClearStoresState) {}
        if (state is GetGoogleStoresSuccessState) {
          state.googleStores.map((store) {
            setState(() {
              _markers.add(
                Marker(
                  markerId: MarkerId(store.placeId),
                  position: LatLng(store.lat, store.lng),
                  infoWindow: InfoWindow(title: store.name),
                  icon: marker2,
                  onTap: () {
                    setState(() {
                      isVisible = true;
                    });
                    selectedPlace = store;
                    // carouselController.onReady.then((_) {
                    //   carouselController.animateToPage(
                    //     cubit.googleStores.indexWhere(
                    //         (element) => element.placeId == store.placeId),
                    //     duration: const Duration(milliseconds: 300),
                    //     curve: Curves.easeIn,
                    //   );
                    // });
                  },
                ),
              );
            });
          }).toList();
        }
      },
      builder: (context, state) {
        MapCubit cubit = MapCubit.get(context);

        if (state is GetGoogleStoresLoadingState) {
          return const AppLoading();
        } else if (state is GetGoogleStoresErrorState) {
          return AppError(
            error: state.error,
          );
        } else if (context.watch<MapCubit>().googleStores.isEmpty &&
            context.watch<MapCubit>().endLoadingFirstTime) {
          debugPrint('====== empty ');
          return Center(
            child: Text(
              state is GetGoogleStoresSuccessState ? context.tr.no_data : '',
              style: AppTextStyle.textStyleMediumBlack,
            ),
          );
        } else {
          return Visibility(
              visible: isVisible,
              child: Stack(
                children: [
                  if (selectedPlace != null) ...[
                    GoogleStorWidget(
                      store: selectedPlace!,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.4),
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              isVisible = false;
                            });
                          },
                        ),
                      ),
                    ),
                  ]
                  //SEARCH
                ],
              )

              // CarouselSlider.builder(
              //   options: CarouselOptions(
              //     aspectRatio: 1,
              //     viewportFraction: 0.9,
              //     initialPage: 0,
              //     enableInfiniteScroll: false,
              //     scrollPhysics: const NeverScrollableScrollPhysics(),
              //     enlargeCenterPage: true,
              //     reverse: false,
              //     autoPlay: false,
              //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
              //     autoPlayCurve: Curves.easeInOutBack,
              //     onPageChanged: (index, reason) {
              //       debugPrint('====>REASON: $reason', wrapWidth: 1024);
              //       debugPrint(
              //           '====>INDEX: $index   ${cubit.googleStores.length}',
              //           wrapWidth: 1024);
              //       if (cubit.googleStores.length == index + 1) {
              //         context.read<MapCubit>().getGoogleStores({
              //           'loadMore': true,
              //           'radius': '2000',
              //           'location':
              //               '${widget.latLng.latitude},${widget.latLng.longitude}',
              //           'language':
              //               context.read<AppCubit>().getCurrentLanguage(context),
              //           "city": StorageHelper.getData(key: "selectedCity"),
              //           "type": widget.type,
              //           if (_searchController.text.isNotEmpty)
              //             "keyword": _searchController.text
              //         });
              //       }
              //       final CameraPosition loc = CameraPosition(
              //         target: LatLng(
              //           cubit.googleStores.elementAt(index).lat,
              //           cubit.googleStores.elementAt(index).lng,
              //         ),
              //         zoom: 16,
              //       );
              //       _goToMyCurrentLocation(loc);
              //     },
              //     scrollDirection: Axis.horizontal,
              //   ),
              //   itemCount: (context.watch<MapCubit>().hasReachedEndOfResults ||
              //           !context.watch<MapCubit>().endLoadingFirstTime)
              //       ? cubit.googleStores.length
              //       : context.watch<MapCubit>().loadingMoreResults
              //           ? cubit.googleStores.length + 1
              //           : cubit.googleStores.length,
              //   itemBuilder: (BuildContext context, int index, int realIndex) {
              //     return Builder(
              //       builder: (BuildContext context) {
              //         if (index >= cubit.googleStores.length) {
              //           return _buildLoaderListItem();
              //         } else {
              //           return Stack(
              //             children: [
              //               GoogleStorWidget(
              //                 store: cubit.googleStores[index],
              //               ),

              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: CircleAvatar(
              //                   backgroundColor: Colors.white.withOpacity(0.4),
              //                   child: IconButton(
              //                     icon: const Icon(
              //                       Icons.close,
              //                       color: Colors.black,
              //                     ),
              //                     onPressed: () {
              //                       setState(() {
              //                         isVisible = false;
              //                       });
              //                     },
              //                   ),
              //                 ),
              //               ),

              //               //SEARCH
              //             ],
              //           );
              //         }
              //       },
              //     );
              //   },
              //   carouselController: carouselController,
              // ),
              );
        }
      },
    );
  }

  Widget _buildLoaderListItem() {
    // return const AppLoading(
    //   color: AppColors.loadingColor,
    // );
    if (!context.watch<MapCubit>().hasReachedEndOfResults) {
      return const AppLoading(
        color: AppColors.loadingColor,
      );
    } else {
      return Center(
        child: Text(
          context.tr.no_more_data,
        ),
      );
    }
  }

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      myLocationButtonEnabled: false,
      initialCameraPosition: CameraPosition(
        target: LocationCubit.get(context).latLng,
        zoom: 14.4746,
      ),
      onMapCreated: (GoogleMapController controller) {
        mapController.complete(controller);
        controller.showMarkerInfoWindow(
            MarkerId(context.read<LocationCubit>().latLng.toString()));
        _markers.add(
          Marker(
            markerId: MarkerId(LocationCubit.get(context).latLng.toString()),
            position: LocationCubit.get(context).latLng,
            icon: marker1,
          ),
        );
      },
      onTap: (latLng) {
        setLocations(latLng);
      },
      onLongPress: (latLng) {
        setLocations(latLng);
      },
      markers: _markers,
    );
  }

  Future<void> setLocations(LatLng latLng) async {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        // infoWindow: InfoWindow(title: LocationCubit.get(context).addressName),
        icon: marker1,
      ),
    );
    debugPrint('_MARKERS: $_markers', wrapWidth: 1024);

    final CameraPosition loc = CameraPosition(
      target: latLng,
      zoom: 14,
    );
    _goToMyCurrentLocation(loc);
    // LocationCubit.get(context).setLatLng(latLng);
    // HomeCubit.get(context).getStores({
    //   'latitude': latLng.latitude,
    //   'longitude': latLng.longitude,
    // });
    context.read<MapCubit>().getGoogleStores({
      'radius': '2000',
      'location': '${latLng.latitude},${latLng.longitude}',
      'language': context.read<AppCubit>().getCurrentLanguage(context),
      "city": StorageHelper.getData(key: "selectedCity"),
      "type": widget.type,
      if (_searchController.text.isNotEmpty) "keyword": _searchController.text
    });
    // MapCubit.get(context).getGoogleStores(
    //   '${latLng.latitude},${latLng.longitude}',
    //   AppCubit().getCurrentLanguage(context),
    //   '2000',
    //   '',
    // );
  }

  Future<void> _goToMyCurrentLocation(myLocation) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(myLocation));
  }
}
