import 'package:flutter/foundation.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';
import '../../../../core/services/navigation_service.dart';
import '../../domain/entities/user.dart';

class ProfileProvider {
  Future<AppResponse> getProfile() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.profile,
    ).then(
      (value) {
        debugPrint(
            'value ================================ ${value.toString()}');
        response = AppResponse.fromJson(value.data);
        response.data = User.fromJson(value.data);
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

  Future<AppResponse> updateProfile(values) async {
    late final AppResponse response;
    debugPrint('data body =====> $values');
    await DioHelper.postFormData(
      url: NetworkConstants.profile,
      data: values,
    ).then(
      (value) {
        debugPrint(
            'value ================================ 1  ${value.toString()}');
        response = AppResponse.fromJson(value.data["user"]);
        if (value.data["phone_updated"]) {
          response.phoneUpdated = value.data["phone_updated"];
        } else {
          response.phoneUpdated = value.data["phone_updated"];
          response.data = User.fromJson(value.data["user"]);
        }
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

  Future<AppResponse> changePassword(values, accessToken) async {
    late final AppResponse response;

    await DioHelper.postFormData(
            url: NetworkConstants.changePassword,
            data: values,
            accessToken: accessToken)
        .then(
      (value) {
        value.data = {
          "message": NavigationService
              .navigatorKey.currentContext!.tr.password_changed,
        };
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
}
