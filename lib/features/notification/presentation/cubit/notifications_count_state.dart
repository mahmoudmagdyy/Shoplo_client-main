part of 'notifications_count_cubit.dart';

abstract class NotificationsCountState extends Equatable {
  const NotificationsCountState();

  @override
  List<Object> get props => [];
}

class NotificationsCountInitial extends NotificationsCountState {}

class NotificationsCountLoadingState extends NotificationsCountState {}

class NotificationsCountSuccessState extends NotificationsCountState {
  final int notificationsCount;
  const NotificationsCountSuccessState(this.notificationsCount);
}

class NotificationsCountErrorState extends NotificationsCountState {
  final String error;
  const NotificationsCountErrorState(this.error);
}
