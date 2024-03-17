import '../../../../core/core_model/app_response.dart';

abstract class NotificationsInterface {
  Future<AppResponse> getNotifications(query);
  Future<AppResponse> getNotificationsCount();
  Future<AppResponse> readNotification(id);
  Future<AppResponse> removeNotification(id);
}
