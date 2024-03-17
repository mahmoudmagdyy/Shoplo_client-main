import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/widgets/app_toast.dart';
import 'package:uuid/uuid.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_loading.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../../data/models/map_search_suggestion.dart';
import '../../data/models/place_details.dart';
import '../cubit/map/map_cubit.dart';
import '../widgets/place_item.dart';

class MapSearchScreen extends StatefulWidget {
  final LatLng latLng;
  final String? country;
  const MapSearchScreen({
    Key? key,
    required this.latLng,
    this.country,
  }) : super(key: key);

  @override
  MapSearchScreenState createState() => MapSearchScreenState();
}

class MapSearchScreenState extends State<MapSearchScreen> {
  final _formKey = GlobalKey<FormState>();
  bool agreedShoppingConfirmation = false;

  Completer<GoogleMapController> mapController = Completer();
  FloatingSearchBarController controller = FloatingSearchBarController();
  late SuggestionPlace suggestionPlace;
  late PlaceDetails placeDetails;
  late LatLng currentLatLng;
  LatLng _initialLanLng = const LatLng(21.42385875366792, 39.82566893781161);
  final Set<Marker> _markers = <Marker>{};
  final Map<String, dynamic> _address = {"text": "", "lat": "", "lng": ""};
  CameraPosition? currentLocation;
  double radius = 10000;

  @override
  void initState() {
    log('COUNTRY: ${widget.country}');
    super.initState();
    _initialLanLng = widget.latLng;
    debugPrint('_INITIAL LAN LNG: $_initialLanLng', wrapWidth: 1024);
    _setLocations();
  }

  Future<void> _setLocations() async {
    await setLocations(widget.latLng);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapAddressCubit, MapState>(
      listener: (context, state) {
        if (state is GetReverseGeocodingSuccessState) {
          setState(() {
            _address['text'] = state.placeDetails.address;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: NetworkSensitive(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      buildMap(),
                      buildFloatingSearchBar(),
                      if (_address['text'] != null)
                        Positioned(
                          bottom: 20,
                          right: 10,
                          left: 10,
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.primaryL,
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  _address["text"],
                                  // textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppButton(
                          onPressed: () {
                            //Navigator.pop(context, currentLatLng);
                            Navigator.pop(context, _address);
                          },
                          title: context.tr.confirm,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: true,
      circles: <Circle>{
        Circle(
          circleId: const CircleId('1'),
          center: _initialLanLng,
          radius: radius,
          fillColor: AppColors.primaryL.withOpacity(0.2),
          strokeColor: AppColors.primaryL.withOpacity(0.2),
        ),
      },
      initialCameraPosition: CameraPosition(
        target: _initialLanLng,
        zoom: 15,
      ),
      onMapCreated: (GoogleMapController controller) {
        mapController.complete(controller);
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

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return BlocBuilder<MapAddressCubit, MapState>(
      builder: (context, state) {
        MapAddressCubit cubit = MapAddressCubit.get(context);

        return FloatingSearchBar(
          clearQueryOnClose: true,
          accentColor: AppColors.primaryL,
          controller: controller,
          hint: context.tr.my_addresses,
          scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
          transitionDuration: const Duration(milliseconds: 800),
          transitionCurve: Curves.easeInOut,
          physics: const BouncingScrollPhysics(),
          axisAlignment: isPortrait ? 0.0 : -1.0,
          openAxisAlignment: 0.0,
          width: isPortrait ? 600 : 500,
          debounceDelay: const Duration(milliseconds: 500),
          onFocusChanged: (value) {
            cubit.emptySearchMapSuggestions();
          },
          onQueryChanged: (query) {
            final sessionToken = const Uuid().v4();
            cubit.getGetSuggestion(
              query,
              sessionToken,
              "ar",
              country: widget
                  .country /*AppCubit.get(context).getCurrentLanguage(context)*/,
            );
            // Call your model, bloc, controller here.
          },
          // Specify a custom transition to be used for
          // animating between opened and closed stated.
          transition: CircularFloatingSearchBarTransition(),
          actions: [
            FloatingSearchBarAction(
              showIfOpened: false,
              child: CircularButton(
                icon: const Icon(
                  Icons.place_outlined,
                  color: AppColors.red,
                ),
                onPressed: () {
                  setLocations(_initialLanLng);
                },
              ),
            ),
            FloatingSearchBarAction.searchToClear(
              showIfClosed: false,
            ),
          ],
          progress: state is GetSuggestionLoadingState,
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.white,
                elevation: 4.0,
                child: buildSuggestionList(),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildSuggestionList() {
    return BlocConsumer<MapAddressCubit, MapState>(
      listener: (context, state) {
        if (state is GetPlaceDetailsSuccessState) {
          setState(() {
            _address['text'] = state.placeDetails.address;
          });
          setLocations(
            LatLng(state.placeDetails.lat, state.placeDetails.lng),
          );
        }
      },
      builder: (context, state) {
        MapAddressCubit cubit = MapAddressCubit.get(context);
        if (state is GetSuggestionLoadingState) {
          return const AppLoading();
        } else if (state is GetSuggestionSuccessState) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () async {
                  suggestionPlace = cubit.searchMapSuggestions[index];

                  final sessionToken = const Uuid().v4();
                  cubit.getGetPlaceDetails(
                    cubit.searchMapSuggestions[index].id,
                    sessionToken,
                    "ar" /*AppCubit.get(context).getCurrentLanguage(context)*/,
                  );
                  controller.close();
                },
                child: PlaceItem(
                  suggestion: cubit.searchMapSuggestions[index],
                ),
              );
            },
            itemCount: cubit.searchMapSuggestions.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<void> setLocations(LatLng latLng) async {
    // check if location in 20000 meter from initial location
    final distance = Geolocator.distanceBetween(
      _initialLanLng.latitude,
      _initialLanLng.longitude,
      latLng.latitude,
      latLng.longitude,
    );
    if (distance > radius) {
      AppToast.showToastError(context.tr.out_of_range);
      return;
    }
    MapAddressCubit cubit = MapAddressCubit.get(context);
    cubit.getReverseGeocoding(
      '${latLng.latitude},${latLng.longitude}',
      "ar" /*AppCubit.get(context).getCurrentLanguage(context)*/,
    );

    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        infoWindow: InfoWindow(title: _address['text']),
        icon: BitmapDescriptor.defaultMarkerWithHue(40),
      ),
    );
    final CameraPosition loc = CameraPosition(
      target: latLng,
      zoom: 15,
    );
    _goToMyCurrentLocation(loc);

    setState(() {
      currentLatLng = latLng;
      _address["lat"] = latLng.latitude;
      _address["lng"] = latLng.longitude;
    });
  }

  Future<void> _goToMyCurrentLocation(myLocation) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(myLocation));
  }
}
