part of 'multiple_orders_cubit.dart';

abstract class MultipleOrdersState extends Equatable {
  const MultipleOrdersState();

  @override
  List<Object> get props => [];
}

class MultipleOrdersInitial extends MultipleOrdersState {}

// error
class MultipleOrdersErrorState extends MultipleOrdersState {
  final String error;

  const MultipleOrdersErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class MultipleOrdersRefreshFieldsState extends MultipleOrdersState {
  final String type;
  const MultipleOrdersRefreshFieldsState(this.type);
  @override
  List<Object> get props => [type];
}

class MultipleOrdersAddOrderDescriptionState extends MultipleOrdersState {
  final int length;

  const MultipleOrdersAddOrderDescriptionState(this.length);

  @override
  List<Object> get props => [length];
}

class MultipleOrdersRemoveOrderDescriptionState extends MultipleOrdersState {
  final int length;
  const MultipleOrdersRemoveOrderDescriptionState(this.length);
  @override
  List<Object> get props => [length];
}

//preview order loading
class MultipleOrdersPreviewOrderLoadingState extends MultipleOrdersState {}

//preview order success
class MultipleOrdersPreviewOrderSuccessState extends MultipleOrdersState {
  CreateMultipleOrderRequest request;
  MultipleOrdersPreviewOrderSuccessState(this.request);
}
