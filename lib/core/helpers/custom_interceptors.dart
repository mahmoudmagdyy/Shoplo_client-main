import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shoplo_client/features/auth/domain/repositories/auth_statics.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST => [${options.method}] => PATH: ${options.path}');
    debugPrint('RESPONSE => [${options.headers.toString()}] ');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE => [${response.statusCode}] => PATH: ${response.requestOptions.path}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('onError: $err');
    debugPrint(
        'ERROR => [${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response?.statusCode == 409 || err.response?.statusCode == 403
        //  &&
        //     err.requestOptions.path != NetworkConstants.login &&
        //     err.requestOptions.path != NetworkConstants.forgetPassword
        ) {
      // AppSnackBar.showError(err.response?.data['error'] ?? '');
      debugPrint('########################## 111111');
      if (err.response?.statusCode == 403) {
        AuthStatics.logout();
      }

      // AppCubit cubit =
      //     AppCubit.get(NavigationService.navigatorKey.currentContext!);
      // cubit.logout();
      return super.onError(err, handler);
    } else {
      return super.onError(err, handler);
    }
  }
}
