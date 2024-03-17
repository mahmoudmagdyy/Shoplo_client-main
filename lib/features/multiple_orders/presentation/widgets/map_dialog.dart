import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/multiple_orders/presentation/cubit/order_map_cubit.dart';
import 'package:shoplo_client/features/multiple_orders/presentation/cubit/order_map_states.dart';

import '../../../../widgets/form_field/search_text_field.dart';
import '../../../home/presentation/widgets/new_store_widget.dart';
import '../../../layout/presentation/cubit/app/app_cubit.dart';
import 'map_logic.dart';

class MapDialog extends StatefulWidget {
  const MapDialog({super.key, required this.latLng, required this.city});
  final LatLng latLng;
  final String city;

  @override
  State<MapDialog> createState() => _MapDialogState();
}

class _MapDialogState extends State<MapDialog> with MapLogicMixin {
  @override
  void initState() {
    latLng = widget.latLng;
    setMapIcons();
    super.initState();
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: BlocProvider(
        create: (context) => OrderMapCubit(),
        child: BlocConsumer<OrderMapCubit, OrderMapState>(
            listener: (context, state) {
          if (state is OrderMapLoadedState) {
            addMarkers(
              state.stores,
              onTapMarker: (p0) {
                final cubit = OrderMapCubit.get(context);
                cubit.setSelectedPlace(p0);
              },
            );
          }
        }, builder: (context, state) {
          final cubit = OrderMapCubit.get(context);
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(latLng.latitude, latLng.longitude),
                  zoom: 14,
                ),
                onMapCreated: (controller) {
                  mapController.complete(controller);
                  _getStores(cubit, context);
                },
                markers: markers,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SearchTextField(
                    hint: context.tr.search_your_favorite_store,
                    controller: _searchController,
                    onChanged: (s) {
                      _getStores(cubit, context);
                    },
                  ),
                ),
              ),
              if (cubit.selectedPlace != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        NewStoreWidget(
                          store: cubit.selectedPlace!,
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(cubit.selectedPlace);
                            },
                            child: Text(context.tr.confirm),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  void _getStores(OrderMapCubit cubit, BuildContext context) {
    cubit.getGoogleStores({
      'radius': '50000',
      'location': '${latLng.latitude},${latLng.longitude}',
      'language': context.read<AppCubit>().getCurrentLanguage(context),
      "city": widget.city,
      "type": "store",
      "keyword": _searchController.text,
    });
  }
}
