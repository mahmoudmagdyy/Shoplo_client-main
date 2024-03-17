part of 'ship_by_global_list_cubit.dart';

abstract class ShipByGlobalListState extends Equatable {
  const ShipByGlobalListState();

  @override
  List<Object> get props => [];
}

class ShipByGlobalListInitial extends ShipByGlobalListState {}

class ShipByGlobalListErrorState extends ShipByGlobalListState {
  //string
  final String errors;

  const ShipByGlobalListErrorState(this.errors);
}

class ShipByGlobalListLoadingState extends ShipByGlobalListState {}

class ShipByGlobalListLoadingNextPageState extends ShipByGlobalListState {}

class ShipByGlobalListSuccessState extends ShipByGlobalListState {
  final List<OrderModel> orders;

  const ShipByGlobalListSuccessState(this.orders);
}
