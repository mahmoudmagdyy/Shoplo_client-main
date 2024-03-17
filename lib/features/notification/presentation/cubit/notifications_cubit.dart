import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_sources/notifications_data_provider.dart';
import '../../data/models/notification_model.dart';
import '../../data/repositories/notifications_repository.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  static NotificationsCubit get(context) => BlocProvider.of(context);

  static final NotificationsDataProvider dataProvider = NotificationsDataProvider();
  static final NotificationsRepository repository = NotificationsRepository(dataProvider);

  final List<NotificationModel> notifications = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  bool loadingMoreResults = false;
  Map<String, dynamic> query = {
    'page': 1,
    'per_page': 10,
  };

  /// getNotifications
  void getNotifications(Map<String, dynamic> queryData) async {
    debugPrint('QUERYDATA: $queryData}', wrapWidth: 1024);
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      query.clear();
      query['page'] = 1;
      query['per_page'] = 10;
      query.addAll(queryData);
    }
    if (!endLoadingFirstTime) {
      notifications.clear();
    }
    debugPrint('QUERY: $query', wrapWidth: 1024);

    if (query['page'] == 1) {
      // query.addAll({
      //   'is_read': 1,
      // });

      emit(NotificationsLoadingState());
    } else {
      loadingMoreResults = true;
      emit(NotificationsLoadingNextPageState());
    }
    repository.getNotifications(query).then(
      (value) {
        log('getNotifications ==> ${value.toString()}');
        loadingMoreResults = false;
        if (value.errorMessages != null) {
          emit(NotificationsErrorState(value.errorMessages!));
        } else {
          endLoadingFirstTime = true;
          List<NotificationModel> notificationsList = [];
          value.data.forEach((item) {
            notificationsList.add(NotificationModel.fromJson(item));
          });

          debugPrint('_Notifications ${notifications.length}');
          if (query['page'] != 1) {
            debugPrint('----- lode more ');
            notifications.addAll(notificationsList);
          } else {
            notifications.clear();
            notifications.addAll(notificationsList);
          }
          if (notifications.length == value.meta['total']) {
            debugPrint('============== done request');
            hasReachedEndOfResults = true;
          } else if (notificationsList.length < value.meta['total']) {
            hasReachedEndOfResults = false;
          }
          debugPrint('notifications ${notifications.length}');
          if (query['page'] < value.meta['last_page']) {
            debugPrint('load more 2222 page ++ ');
            query['page'] += 1;
          } else {
            query['page'] = 1;
          }

          emit(NotificationsSuccessState(notifications));
        }
      },
    );
  }

  String notificationId = "-1";

  /// read Notifications
  void readNotification(id) {
    notificationId = id;
    emit(ReadNotificationLoadingState());

    repository.readNotification(id).then(
      (value) {
        debugPrint('readNotification ==> ${value.toString()}');
        if (value.errorMessages != null) {
          emit(ReadNotificationErrorState(value.errorMessages!));
        } else {
          emit(ReadNotificationSuccessState(value.data));
        }
      },
    );
  }

  /// remove Notifications
  void removeNotification(id) {
    notificationId = id;
    emit(ReadNotificationLoadingState());

    repository.removeNotification(id).then(
      (value) {
        debugPrint('removeNotification ==> ${value.toString()}');
        if (value.errorMessages != null) {
          emit(ReadNotificationErrorState(value.errorMessages!));
        } else {
          emit(ReadNotificationSuccessState(value.data));
        }
      },
    );
  }
}
