import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/notifications_data_provider.dart';
import '../../data/repositories/notifications_repository.dart';

part 'notifications_count_state.dart';

class NotificationsCountCubit extends Cubit<NotificationsCountState> {
  NotificationsCountCubit() : super(NotificationsCountInitial());

  static NotificationsCountCubit get(context) => BlocProvider.of(context);

  static final NotificationsDataProvider dataProvider =
      NotificationsDataProvider();
  static final NotificationsRepository repository =
      NotificationsRepository(dataProvider);

  int notificationsCount = 0;

  /// get Notification count

  void getNotificationsCount() {
    emit(NotificationsCountLoadingState());
    repository.getNotificationsCount().then(
      (value) {
        if (value.errorMessages != null) {
          emit(NotificationsCountErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(NotificationsCountErrorState(value.errors!));
        } else {
          notificationsCount = value.data['notifications_count'];
          debugPrint(
              'VALUE notifications_count: ${value.data['notifications_count']}',
              wrapWidth: 1024);
          emit(NotificationsCountSuccessState(
              value.data['notifications_count']));
        }
      },
    );
  }

  void resetNotificationCount(){
    notificationsCount =0 ;
  }
}
