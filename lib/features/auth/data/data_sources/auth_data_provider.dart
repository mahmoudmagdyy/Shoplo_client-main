import 'package:flutter/foundation.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/auth/data/models/user_data.dart';

import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';
import '../../../../core/services/navigation_service.dart';

class AuthDataProvider {
  Future<AppResponse> register(values) async {
    late final AppResponse response;

    await DioHelper.postFormData(url: NetworkConstants.register, data: values).then(
      (value) {
        debugPrint('res ================================ ${value.toString()}');
        value.data = {
          "message": NavigationService.navigatorKey.currentContext!.tr.register_success,
        };
        response = AppResponse.fromJson(value.data);
        response.data = value.data['message'];
      },
    ).catchError(
      (error) {
        debugPrint('error ================================ ${error.toString()}');

        if (error?.response != null) {
          debugPrint('error RES ================================ ${error.response.toString()}');

          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> login(Map<String, dynamic> values) async {
    late final AppResponse response;

    await DioHelper.postFormData(
      url: NetworkConstants.login,
      data: values,
    ).then(
      (value) {
        debugPrint("🚀 login data provider  ${value.data}");

        response = AppResponse.fromJson(value.data);
        response.data = UserDataModel.fromJson(value.data);
      },
    ).catchError(
      (error) {
        // debugPrint('error ================================ ${error?.message}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> verifyCode(values) async {
    late final AppResponse response;

    await DioHelper.postFormData(
      url: NetworkConstants.verifyAccount,
      data: values,
    ).then(
      (value) {
        debugPrint('res ================================ ${value.toString()}');
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

  Future<AppResponse> resendCode(values) async {
    late final AppResponse response;

    await DioHelper.postFormData(url: NetworkConstants.resendCode, data: values).then(
      (value) {
        value.data = {
          "message": NavigationService.navigatorKey.currentContext!.tr.verification_code_sent,
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

  Future<AppResponse> logout(Map<String, dynamic> values) async {
    late final AppResponse response;

    await DioHelper.postFormData(
      url: NetworkConstants.logout,
      data: values,
    ).then(
      (value) {
        debugPrint('VALUE logout: $value}', wrapWidth: 1024);
        response = AppResponse.fromJson({'data': value});
        // response.data = LoginResModel.fromJson(response.data);
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

  Future<AppResponse> forgetPassword(values) async {
    late final AppResponse response;

    debugPrint("forgot value print => $values");
    await DioHelper.postFormData(url: NetworkConstants.forgotPassword, data: values).then(
      (value) {
        debugPrint("forgot response print => $value");
        value.data = {
          "message": NavigationService.navigatorKey.currentContext!.tr.verification_code_sent,
        };
        response = AppResponse.fromJson(value.data);
        debugPrint("forgot response print 2 => $value");
        response.data = value.data;
      },
    ).catchError(
      (error) {
        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> verifyToken(values, accessToken) async {
    late final AppResponse response;

    await DioHelper.postFormData(
      url: NetworkConstants.verifyForgotPassword,
      data: values,
    ).then(
      (value) {
        debugPrint('res ================================ ${value.toString()}');
        value.data = {
          "message": NavigationService.navigatorKey.currentContext!.tr.active_success,
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

  Future<AppResponse> verifyUpdatePhone(values) async {
    late final AppResponse response;

    await DioHelper.postFormData(
      url: NetworkConstants.verifyUpdatePhone,
      data: values,
    ).then(
      (value) {
        debugPrint('res ================================ ${value.toString()}');
        value.data = {
          "message": NavigationService.navigatorKey.currentContext!.tr.update_successfully,
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

  Future<AppResponse> resetPassword(values) async {
    late final AppResponse response;

    await DioHelper.postFormData(url: NetworkConstants.resetPassword, data: values).then(
      (value) {
        value.data = {
          "message": NavigationService.navigatorKey.currentContext!.tr.password_changed,
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

  Future<AppResponse> deleteAccount(values) async {
    late final AppResponse response;

    await DioHelper.postFormData(
      url: NetworkConstants.deleteAccount,
      data: values,
    ).then(
      (value) {
        debugPrint('VALUE deleteAccount: $value}', wrapWidth: 1024);
        response = AppResponse.fromJson({'data': value});
        // response.data = LoginResModel.fromJson(response.data);
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
