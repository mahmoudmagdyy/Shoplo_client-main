import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoplo_client/core/helpers/currency_helper.dart';
import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';
import '../../../../core/helpers/storage_helper.dart';
import '../../../auth/data/models/user_data.dart';

class UserRepository {
  static UserDataModel? initUserData() {
    debugPrint('APPP User data ');
    UserDataModel userData;

    if (StorageHelper.getObject(key: 'userData') != false) {
      userData = UserDataModel.fromJson(StorageHelper.getObject(key: 'userData'));

      debugPrint('userData -------+ ==> ${userData.user.toString()}');
      debugPrint('accessToken ------+ ==> ${userData.accessToken.toString()}');

      if (userData.toJson().isNotEmpty && userData.user.isActive) {
        return userData;
      }
    }
    return null;
  }

  static Future<AppResponse> changeCurrency(Map<String, dynamic> query) async {
    late final AppResponse response;

    log('query $query');
    await DioHelper.postData(url: NetworkConstants.changeCountry, data: query).then(
      (value) {
        log('value $value');

        response = AppResponse.fromJson(value.data);
        StorageHelper.saveData(key: 'currency', value: value.data['currency']);
        CurrencyHelper.currency = value.data['currency'];
        debugPrint('RESPONSE : $response', wrapWidth: 1024);
      },
    ).catchError(
      (error) {
        debugPrint('error================================ ${error.toString()}');

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
