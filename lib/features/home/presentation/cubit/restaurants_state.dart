part of 'restaurants_cubit.dart';

abstract class RestaurantsState extends Equatable {
  const RestaurantsState();

  @override
  List<Object> get props => [];
}

class RestaurantsInitial extends RestaurantsState {}

class GetRestaurantsLoadingState extends RestaurantsState {}

class GetRestaurantsLoadingNextPageState extends RestaurantsState {}

class GetRestaurantsSuccessState extends RestaurantsState {
  final List<PlaceDetails> restaurants;
  const GetRestaurantsSuccessState(this.restaurants);
}

class GetRestaurantsErrorState extends RestaurantsState {
  final String error;
  const GetRestaurantsErrorState(this.error);
}
