part of 'order_details_cubit.dart';

abstract class OrderDetailsState extends Equatable {
  const OrderDetailsState();

  @override
  List<Object> get props => [];
}

class OrderDetailsInitial extends OrderDetailsState {}

class GetOrderDetailsLoadingState extends OrderDetailsState {}

class GetOrderDetailsLoadingNextPageState extends OrderDetailsState {}

class GetOrderDetailsSuccessState extends OrderDetailsState {
  final OrderModel orderModel;
  const GetOrderDetailsSuccessState(this.orderModel);
}

class GetOrderDetailsErrorState extends OrderDetailsState {
  final String error;
  const GetOrderDetailsErrorState(this.error);
}
