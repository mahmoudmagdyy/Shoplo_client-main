part of 'ship_by_global_cubit.dart';

abstract class ShipByGlobalState extends Equatable {
  const ShipByGlobalState();

  @override
  List<Object> get props => [];
}

class ShipByGlobalInitial extends ShipByGlobalState {}

class ShipByGlobalErrorState extends ShipByGlobalState {
  //string
  final String errors;

  const ShipByGlobalErrorState(this.errors);
}

class ShipByGlobalLoadingState extends ShipByGlobalState {}

class ShipByGlobalSuccessState extends ShipByGlobalState {
  final OrderModel model;
  final String message;

  const ShipByGlobalSuccessState(this.model, this.message);
}

class ShipByGlobalPaymentState extends ShipByGlobalState {
  final String message;

  const ShipByGlobalPaymentState(
    this.message,
  );
}
