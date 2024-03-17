import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_error.dart';
import '../../../../core/core_model/app_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/helpers/dio_helper.dart';
import '../../../../core/services/navigation_service.dart';

class ContactUsDataProvider {
  Future<AppResponse> sendContactUs(values) async {
    late final AppResponse response;

    await DioHelper.postFormData(
      url: NetworkConstants.contactUs,
      data: values,
    ).then(
      (value) {
        value.data={
          "message":AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!.sent_successfully,
        };
        response = AppResponse.fromJson(value.data);
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

  ///getContactUsType
  Future<Either<AppError,AppResponse>> getContactUsTypes() async {
    late final AppResponse appResponse;
    late final AppError appError;
    await DioHelper.getData(
      url: NetworkConstants.contactUsTypes,
    ).then(
          (value) {
        debugPrint('VALUE in get getContactUsTypes: ${value.data}', wrapWidth: 1024);
        appResponse = AppResponse.fromJson({'data': value.data["data"]});
        debugPrint('appResponse in get getContactUsTypes: $appResponse', wrapWidth: 1024);

      },
    ).catchError(
          (error) {
        debugPrint('ERROR:@@@@ $error}', wrapWidth: 1024);
        if (error?.response != null) {
          appError = AppError.withErrorResponse(error.response);
        } else {
          if(error.type == "response")
            appError = AppError.withErrorString(error.message);
        }

      },
    );
    if(appResponse !=null){
      return right(appResponse);
    }
    else {
      return left(appError);
    }
  }

  // Future<AppResponse> getContactTypes() async {
  //   late final AppResponse response;
  //   await DioHelper.getData(
  //     url: NetworkConstants.login,
  //     // query: query,
  //   ).then(
  //     (value) {
  //       response = AppResponse.fromJson({'data': value.data});
  //       // response.meta = value.data['meta'];
  //       // response.data = value.data['data'];
  //     },
  //   ).catchError(
  //     (error) {
  //       debugPrint('error ================================ ${error?.message}');
  //
  //       if (error?.response != null) {
  //         response = AppResponse.withErrorResponse(error.response);
  //       } else {
  //         response = AppResponse.withErrorString(error.message);
  //       }
  //     },
  //   );
  //   return response;
  // }
}
