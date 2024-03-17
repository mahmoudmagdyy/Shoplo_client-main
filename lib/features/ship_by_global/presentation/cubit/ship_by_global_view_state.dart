part of 'ship_by_global_view_cubit.dart';

abstract class ShipByGlobalViewState extends Equatable {
  const ShipByGlobalViewState();

  @override
  List<Object> get props => [];
}

class ShipByGlobalViewInitial extends ShipByGlobalViewState {}

class ShipByGlobalViewErrorState extends ShipByGlobalViewState {
  //string
  final String errors;

  const ShipByGlobalViewErrorState(this.errors);
}

class ShipByGlobalViewLoadingState extends ShipByGlobalViewState {}

class ShipByGlobalViewSuccessState extends ShipByGlobalViewState {
  final OrderModel model;

  const ShipByGlobalViewSuccessState(this.model);
}

class ShipByGlobalViewChangeStatusSuccessState extends ShipByGlobalViewState {
  final String message;

  const ShipByGlobalViewChangeStatusSuccessState(this.message);
}

class ShipByGlobalViewChangeStatusErrorState extends ShipByGlobalViewState {
  final String errors;

  const ShipByGlobalViewChangeStatusErrorState(this.errors);
}

class ShipByGlobalViewChangeStatusLoadingState extends ShipByGlobalViewState {}
