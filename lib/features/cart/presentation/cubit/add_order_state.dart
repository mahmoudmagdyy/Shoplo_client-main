part of 'add_order_cubit.dart';

abstract class AddOrderState extends Equatable {
  const AddOrderState();

  @override
  List<Object> get props => [];
}

class AddOrderInitial extends AddOrderState {}

/// add order
class SetOrderDataState extends AddOrderState {}

class AddOrderLoadingState extends AddOrderState {}

class AddOrderSuccessState extends AddOrderState {
  final String message;
  final OrderModel order;
  const AddOrderSuccessState(this.order, this.message);
}

class AddOrderErrorState extends AddOrderState {
  final String error;
  const AddOrderErrorState(this.error);
}

/// preview order
class PreviewOrderLoadingState extends AddOrderState {}

class PreviewOrderSuccessState extends AddOrderState {
  final PreviewOrderModal order;
  const PreviewOrderSuccessState(this.order);
}

class PreviewOrderErrorState extends AddOrderState {
  final String error;
  const PreviewOrderErrorState(this.error);
}
