import 'package:flutter/foundation.dart';

import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';

class UploaderDataProvider {
  Future<AppResponse> upload(data) async {
    late final AppResponse response;

    await DioHelper.postFormData(url: NetworkConstants.uploader, data: data)
        .then(
      (value) {
        debugPrint(
            'res uploader ================================ ${value.data.toString()}');

        response = AppResponse.fromJson(value.data);
        response.data = value.data;
      },
    ).catchError(
      (error) {
        debugPrint(
            'error uploader ================================ ${error.response}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> multipleUploader(data) async {
    late final AppResponse response;
    await DioHelper.postFormData(
            url: NetworkConstants.multipleUploader, data: data)
        .then(
      (value) {
        debugPrint(
            'res uploader ================================ ${value.data.toString()}');
        //response = AppResponse.fromJson(value.data);
        response = AppResponse.fromJson({'data': value.data});
        response.data = value.data;
      },
    ).catchError(
      (error) {
        debugPrint(
            'error uploader ================================ ${error.response}');

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
