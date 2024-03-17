part of 'stores_cubit.dart';

abstract class StoresState extends Equatable {
  const StoresState();

  @override
  List<Object> get props => [];
}

class StoresInitial extends StoresState {}

class GetStoresLoadingState extends StoresState {}

class GetStoresLoadingNextPageState extends StoresState {}

class GetStoresSuccessState extends StoresState {
  final List<PlaceDetails> stores;
  const GetStoresSuccessState(this.stores);
}

class GetStoresErrorState extends StoresState {
  final String error;
  const GetStoresErrorState(this.error);
}
