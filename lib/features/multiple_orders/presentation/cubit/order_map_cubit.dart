import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/data/datasources/search_map_data_provider.dart';
import '../../../home/data/models/place_details.dart';
import '../../../home/data/repositories/search_map_suggestions_repository.dart';
import 'order_map_states.dart';

class OrderMapCubit extends Cubit<OrderMapState> {
  OrderMapCubit() : super(OrderMapInitial());

  static OrderMapCubit get(context) => BlocProvider.of(context);
  static final dataProvider = SearchMapSuggestionsDataProvider();
  static final SearchMapSuggestionsRepository repository =
      SearchMapSuggestionsRepository(dataProvider);

  Future<void> getGoogleStores(Map<String, dynamic> query) async {
    final result = await repository.getGoogleStores(query);
    if (result.errorMessages != null) {
      emit(OrderMapErrorState(result.errorMessages!));
    } else if (result.errors != null) {
      emit(OrderMapErrorState(result.errors!));
    } else {
      List<PlaceDetails> places = [];
      if (result.data.length > 0) {
        result.data.forEach((item) {
          places.add(PlaceDetails.fromJson({...item, 'isGoogleStore': true}));
        });
      }
      emit(OrderMapLoadedState(places));
    }
  }

  PlaceDetails? selectedPlace;
  void setSelectedPlace(PlaceDetails place) {
    selectedPlace = place;
    emit(OrderMapSelectedState(place));
  }
}
