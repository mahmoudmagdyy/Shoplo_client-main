import 'package:flutter/foundation.dart';
import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';

class NotificationsDataProvider {

  Future<AppResponse> getNotifications(query) async {
    debugPrint('QUERY xxxcc: $query', wrapWidth: 1024);
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.notification,
      query: query,
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
        response.meta = value.data['meta'];
        response.data = value.data['data'];
      },
    ).catchError(
      (error) {
        debugPrint('error ================================ ${error?.message}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> getNotificationsCount() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.notificationCount,
    ).then(
      (value) {
        debugPrint('VALUExxx: $value', wrapWidth: 1024);
        response = AppResponse.fromJson(value.data);
        response.data = value.data;
      },
    ).catchError(
      (error) {
        debugPrint('error ================================ ${error?.message}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> readNotification(id) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: '${NetworkConstants.login}/$id',
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
      },
    ).catchError(
      (error) {
        debugPrint('error ================================ ${error?.message}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> removeNotification(id) async {
    late final AppResponse response;
    await DioHelper.getData(
            url: '${NetworkConstants.login}/$id',
            )
        .then(
      (value) {
        response = AppResponse.fromJson(value.data);
      },
    ).catchError(
      (error) {
        debugPrint('error ================================ ${error?.message}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }
}
