part of 'order_cubit.dart';

@immutable
abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrdersInitial extends OrderState {}

class OrdersLoadingState extends OrderState {}

class OrdersLoadingNextPageState extends OrderState {}

class OrdersSuccessState extends OrderState {
  final List<OrderModel> orders;
  const OrdersSuccessState(this.orders);
}

class OrdersErrorState extends OrderState {
  final String error;
  const OrdersErrorState(this.error);
}

class FinishedOrdersLoadingState extends OrderState {}

class FinishedOrdersLoadingNextPageState extends OrderState {}

class FinishedOrdersSuccessState extends OrderState {
  final List<OrderModel> orders;
  const FinishedOrdersSuccessState(this.orders);
}

class FinishedOrdersErrorState extends OrderState {
  final String error;
  const FinishedOrdersErrorState(this.error);
}

class RejectedOrdersLoadingState extends OrderState {}

class RejectedOrdersLoadingNextPageState extends OrderState {}

class RejectedOrdersSuccessState extends OrderState {
  final List<OrderModel> orders;
  const RejectedOrdersSuccessState(this.orders);
}

class RejectedOrdersErrorState extends OrderState {
  final String error;
  const RejectedOrdersErrorState(this.error);
}

class ChangeOrderStatusLoadingState extends OrderState {}

class ChangeOrderStatusSuccessState extends OrderState {
  const ChangeOrderStatusSuccessState();
}

class ChangeOrderStatusErrorState extends OrderState {
  final String error;
  const ChangeOrderStatusErrorState(this.error);
}
