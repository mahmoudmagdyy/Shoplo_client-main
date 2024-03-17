import '../../../../core/core_model/app_response.dart';
import '../../domain/repositories/notifications_interface.dart';
import '../data_sources/notifications_data_provider.dart';

class NotificationsRepository implements NotificationsInterface {
  final NotificationsDataProvider notificationsDataProvider;

  const NotificationsRepository(this.notificationsDataProvider);

  @override
  Future<AppResponse> getNotifications(query) {
    return notificationsDataProvider.getNotifications(query);
  }

  @override
  Future<AppResponse> readNotification(id) {
    return notificationsDataProvider.readNotification(id);
  }

  @override
  Future<AppResponse> removeNotification(id) {
    return notificationsDataProvider.removeNotification(id);
  }

  @override
  Future<AppResponse> getNotificationsCount() {
    return notificationsDataProvider.getNotificationsCount();
  }
}
