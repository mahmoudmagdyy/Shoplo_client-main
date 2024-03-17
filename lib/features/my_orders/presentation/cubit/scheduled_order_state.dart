import 'package:equatable/equatable.dart';

abstract class ScheduledOrderState extends Equatable {
  const ScheduledOrderState();

  @override
  List<Object> get props => [];
}

class ScheduledOrderInitial extends ScheduledOrderState {}

class AcceptRejectScheduledLoadingState extends ScheduledOrderState {}

class AcceptRejectScheduledSuccessState extends ScheduledOrderState {
  final String status;
  const AcceptRejectScheduledSuccessState(this.status);
}

class AcceptRejectScheduledErrorState extends ScheduledOrderState {
  final String error;
  const AcceptRejectScheduledErrorState(this.error);
}
