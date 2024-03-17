import 'package:flutter/foundation.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';
import '../../../../core/services/navigation_service.dart';

class OrdersDataProvider {
  Future<AppResponse> getOrders(query) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.orders,
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

  Future<AppResponse> getOrderDetails(id) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: '${NetworkConstants.orders}/$id',
    ).then(
      (value) {
        response = AppResponse.fromJson({'data': value.data});
        // response.data = value.data;
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

  Future<AppResponse> changeOrderStatus(id, query) async {
    late final AppResponse response;
    await DioHelper.putData(
      url:
          '${NetworkConstants.orders}/$id${NetworkConstants.changeOrderStatus}',
      data: query,
    ).then(
      (value) {
        debugPrint('VALUE: ${value.data}', wrapWidth: 1024);
        response = AppResponse.fromJson({'data': value.data});
        // response.data = value.data;
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

  Future<AppResponse> addOrder(data) async {
    late final AppResponse response;

    await DioHelper.postFormData(url: NetworkConstants.orders, data: data).then(
      (value) {
        debugPrint(
            'res add Order ================================ ${value.data.toString()}');

        response = AppResponse.fromJson(value.data);
        response.data = value.data;
      },
    ).catchError(
      (error) {
        debugPrint(
            'error addOrder ================================ ${error.response}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> previewOrder(data) async {
    late final AppResponse response;

    await DioHelper.postFormData(url: NetworkConstants.previewOrder, data: data)
        .then(
      (value) {
        debugPrint(
            'res add Order ================================ ${value.data.toString()}');

        response = AppResponse.fromJson(value.data);
        response.data = value.data;
      },
    ).catchError(
      (error) {
        debugPrint('error ================================ ${error.response}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

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

  Future<AppResponse> sendRate(values) async {
    late final AppResponse response;

    await DioHelper.postFormData(
      url: NetworkConstants.rate,
      data: values,
    ).then(
      (value) {
        value.data = {
          "message": NavigationService
              .navigatorKey.currentContext!.tr.sent_successfully,
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

  Future<AppResponse> acceptRejectScheduled(id, query) async {
    late final AppResponse response;
    await DioHelper.putData(
      url: NetworkConstants.acceptRejectScheduled(id),
      data: query,
    ).then(
      (value) {
        debugPrint('VALUE: ${value.data}', wrapWidth: 1024);
        response = AppResponse.fromJson({'data': value.data});
        // response.data = value.data;
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
