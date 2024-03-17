import 'package:flutter/foundation.dart';

import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';

class ChatDataProvider {
  Future<AppResponse> sendMessage(values) async {
    late final AppResponse response;
    await DioHelper.postFormData(
      url: NetworkConstants.sendChat,
      data: values,
    ).then(
      (value) {
        response = AppResponse.fromJson({'data': value.data});
      },
    ).catchError(
      (error) {
        debugPrint("🚀 ~ file: line 19 ~ ChatDataProvider ~ ~ $error");
        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> getMessages(Map<String, dynamic> query) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.chat,
      query: query,
    ).then(
      (value) {
        response = AppResponse.fromJson({'data': value.data});
        // response.meta = value.data['meta'];
        // response.data = value.data['data'];
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

  Future<AppResponse> getChat(query, id) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: '${NetworkConstants.chat}/$id',
      query: query,
    ).then(
      (value) {
        debugPrint('VALUE getChat${value.data.toString()}');
        response = AppResponse.fromJson({'data': value.data});
        // response.meta = response.data['meta'];
        // response.data = response.data['messages'];
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
}
