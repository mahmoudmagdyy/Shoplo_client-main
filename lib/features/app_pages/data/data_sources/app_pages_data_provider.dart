import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shoplo_client/core/core_model/app_error.dart';
import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';
import '../models/app_pages.dart';
import '../models/contact_us_types_model.dart';

class AppPagesDataProvider {

  Future<Either<AppError,AppResponse>> getPageData(url) async {
    late final AppResponse appResponse;
    late final AppError errorResponse;
    await DioHelper.getData(
      url: url,
    ).then(
      (value) {
        debugPrint('VALUE in get: ${value.data}', wrapWidth: 1024);
        appResponse = AppResponse.fromJson({'data': value.data});
        appResponse.data = AppPagesModel.fromJson(value.data);
      },
    ).catchError(
      (error) {
        debugPrint('ERROR: $error}', wrapWidth: 1024);
        errorResponse = AppError.withErrorString(error?.message);
        debugPrint('================================ ${error?.message}');
        return left(errorResponse);
      },
    );
    return right(appResponse);
  }

  Future<AppResponse> getAppSettings() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.login,
    ).then(
      (value) {
        debugPrint('VALUE in get: ${value.data}', wrapWidth: 1024);
        response = AppResponse.fromJson({'data': value.data});
        // response.data = AppPagesModel.fromJson(value.data);
      },
    ).catchError(
      (error) {
        debugPrint('ERROR: $error}', wrapWidth: 1024);
        response = AppResponse.withErrorString(error?.message);
        debugPrint('================================ ${error?.message}');
      },
    );
    return response;
  }

  Future<AppResponse> getFaq(query) async {
    debugPrint('QUERY Faq: $query', wrapWidth: 1024);
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.login,
      query: query,
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
        response.meta = value.data['meta'];
        response.data = value.data['data'];
      },
    ).catchError(
      (error) {
        debugPrint(
            'error faq ================================ ${error?.message}');

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
