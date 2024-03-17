import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/place_details.dart';

part 'restaurants_state.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantsCubit() : super(RestaurantsInitial());
}
