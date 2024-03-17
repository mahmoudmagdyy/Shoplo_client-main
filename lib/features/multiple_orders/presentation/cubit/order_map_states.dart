import 'package:equatable/equatable.dart';
import 'package:shoplo_client/features/home/data/models/place_details.dart';

abstract class OrderMapState extends Equatable {
  const OrderMapState();

  @override
  List<Object> get props => [];
}

class OrderMapInitial extends OrderMapState {}

class OrderMapLoadingState extends OrderMapState {}

class OrderMapErrorState extends OrderMapState {
  final String error;

  const OrderMapErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class OrderMapLoadedState extends OrderMapState {
  final List<PlaceDetails> stores;

  const OrderMapLoadedState(this.stores);

  @override
  List<Object> get props => [stores];
}

class OrderMapSelectedState extends OrderMapState {
  final PlaceDetails store;

  const OrderMapSelectedState(this.store);

  @override
  List<Object> get props => [store];
}
