part of 'multiple_orders_review_cubit.dart';

abstract class MultipleOrdersReviewState extends Equatable {
  const MultipleOrdersReviewState();

  @override
  List<Object> get props => [];
}

class MultipleOrdersReviewInitial extends MultipleOrdersReviewState {}

//loading
class MultipleOrdersReviewLoading extends MultipleOrdersReviewState {}

//success
class MultipleOrdersReviewSuccess extends MultipleOrdersReviewState {
  final OrderModel orderModel;
  final String message;

  const MultipleOrdersReviewSuccess(this.orderModel, this.message);

  @override
  List<Object> get props => [orderModel, message];
}

//error
class MultipleOrdersReviewError extends MultipleOrdersReviewState {
  final String message;

  const MultipleOrdersReviewError(this.message);

  @override
  List<Object> get props => [message];
}
