import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppResponse {
  dynamic data;
  dynamic meta;
  String? errors;
  String? errorMessages;
  int? statusCode;
  dynamic total;
  String? subtotal;
  bool? isActive;
  bool? phoneUpdated;
  String? pageToken;

  AppResponse({
    this.data,
    this.meta,
    this.errors,
    this.errorMessages,
    this.statusCode,
    this.total,
    this.subtotal,
    this.isActive,
    this.phoneUpdated,
    this.pageToken,
  });

  factory AppResponse.fromJson(Map<String, dynamic> json) => AppResponse(
        data: json['data'],
        errors: json['errors'],
        errorMessages: json['errorMessages'],
        statusCode: json['statusCode'],
        total: json['total'],
        subtotal: json['subtotal'],
        isActive: json['isActive'],
        phoneUpdated: json['phone_updated'],
      );

  Map<String, dynamic> toJson() => {
        'data': data,
        'errors': errors,
        'errorMessages': errorMessages,
        'statusCode': statusCode,
        "phone_updated": phoneUpdated,
      };

  static AppResponse withErrorResponse(Response error) {
    debugPrint('withErrorResponse =0=>> ${error.data}');
    debugPrint('withErrorResponse =data=>> $error}');

    final AppResponse response = AppResponse();
    if (error.data['error'].runtimeType == String) {
      if (error.statusCode != 403) {
        response.errors = error.data['error'];
      }
      response.statusCode = error.statusCode;
      if (error.data['is_active'] != null) {
        response.isActive = error.data['is_active'];
      }
    } else {
      debugPrint('withErrorResponse =else =>> ${error.data}');
      if (error.statusCode != 403) {
        response.errors = error.data['error'];
      }
      response.statusCode = error.statusCode;
    }
    return response;
  }

  static AppResponse withErrorString(String error) {
    final AppResponse response = AppResponse();
    response.errorMessages = error;
    return response;
  }

  @override
  String toString() =>
      'data: $data errors: $errors errorMessages: $errorMessages statusCode: $statusCode';
}
