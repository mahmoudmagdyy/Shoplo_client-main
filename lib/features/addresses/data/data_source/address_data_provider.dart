import 'package:flutter/foundation.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';
import '../../../../core/services/navigation_service.dart';

class AddressProvider {
  Future<AppResponse> getMyAddresses() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.addresses,
    ).then(
      (value) {
        debugPrint(
            'value ================================ addresses 1  ${value.toString()}');
        //response = AppResponse.fromJson(value.data);
        response = AppResponse.fromJson({'data': value.data});
        debugPrint(
            'value ================================ addresses 2 ${value.toString()}');
        // response.meta = value.data['meta'];
        debugPrint(
            'value ================================ addresses 3  ${value.toString()}');
        //response.data = value.data['data'];
        response.data = value.data;
        debugPrint(
            'value ================================ addresses 4  ${value.toString()}');
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

  Future<AppResponse> getAddressesDetails(id) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: "${NetworkConstants.addresses}/$id",
    ).then(
      (value) {
        debugPrint(
            'value ================================ addresses 1  ${value.toString()}');
        //response = AppResponse.fromJson(value.data);
        response = AppResponse.fromJson({'data': value.data});
        debugPrint(
            'value ================================ addresses 2 ${value.toString()}');
        // response.meta = value.data['meta'];
        debugPrint(
            'value ================================ addresses 3  ${value.toString()}');
        //response.data = value.data['data'];
        response.data = value.data;
        debugPrint(
            'value ================================ addresses 4  ${value.toString()}');
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

  Future<AppResponse> addAddressProfile(values) async {
    late final AppResponse response;

    await DioHelper.postData(
      url: NetworkConstants.addresses,
      data: values,
    ).then(
      (value) {
        debugPrint(
            'value ================================ ${value.toString()}');
        value.data = {
          "message":
              NavigationService.navigatorKey.currentContext!.tr.address_added,
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

  Future<AppResponse> editAddressProfile(values, id) async {
    late final AppResponse response;
    debugPrint('body ================================ ${values.toString()}');
    await DioHelper.putData(
      url: "${NetworkConstants.addresses}/$id",
      data: values,
    ).then(
      (value) {
        debugPrint(
            'value edit ================================ ${value.toString()}');

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

  Future<AppResponse> deleteAddress(int id) async {
    late final AppResponse response;
    await DioHelper.deleteData(
      data: {},
      url: "${NetworkConstants.addresses}/$id",
    ).then(
      (value) {
        debugPrint(
            'value ================================ ${value.toString()}');
        value.data = {
          "message": NavigationService
              .navigatorKey.currentContext!.tr.deleted_successfully,
        };
        response = AppResponse.fromJson(value.data);
        response.data = value.data;
      },
    ).catchError(
      (error) {
        debugPrint(
            'error ================================ delete ${error?.message}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  ///dropdown countries
  Future<AppResponse> getCountries(query) async {
    late final AppResponse response;
    Map<String, dynamic> queryParams = {
      'correct_data': 1,
    };
    if (query != null) {
      queryParams.addAll(query);
    }
    await DioHelper.getData(
      url: NetworkConstants.dropDownCountries,
      query: queryParams,
    ).then(
      (value) {
        debugPrint('VALUE categories ${value.data.toString()}');
        response = AppResponse.fromJson({"data": value.data});
        response.data = response.data;
      },
    ).catchError(
      (error) {
        debugPrint(
            'error ================================ ${error.toString()}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> getStates(id, query) async {
    Map<String, dynamic> queryParams = {
      'correct_data': 1,
    };
    if (query != null) {
      queryParams.addAll(query);
    }
    late final AppResponse response;
    await DioHelper.getData(
      url: '${NetworkConstants.dropDownStates}?country=$id',
      query: queryParams,
    ).then(
      (value) {
        debugPrint('VALUE states ${value.data.toString()}');
        response = AppResponse.fromJson({'data': value.data});
        response.data = response.data;
      },
    ).catchError(
      (error) {
        debugPrint(
            'error subCategories================================ ${error.toString()}');
        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> getCities(id, query) async {
    late final AppResponse response;
    Map<String, dynamic> queryParams = {
      'correct_data': 1,
    };
    if (query != null) {
      queryParams.addAll(query);
    }
    await DioHelper.getData(
      url: '${NetworkConstants.dropDownCites}?state=$id',
      query: queryParams,
    ).then(
      (value) {
        debugPrint('VALUE cities ${value.data.toString()}');
        response = AppResponse.fromJson({'data': value.data});
        response.data = response.data;
      },
    ).catchError(
      (error) {
        debugPrint(
            'error subCategories================================ ${error.toString()}');
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
