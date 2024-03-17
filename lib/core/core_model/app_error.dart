import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppError {
   String? errors;
   String? errorMessages;
   int? statusCode;
   bool? isActive;

    AppError({
    this.errors,
    this.errorMessages,
    this.statusCode,
    this.isActive,
  });

  factory AppError.fromJson(Map<String, dynamic> json) => AppError(
        errors: json['errors'],
        errorMessages: json['errorMessages'],
        statusCode: json['statusCode'],
        isActive: json['isActive'],
      );

  Map<String, dynamic> toJson() => {
        'errors': errors,
        'errorMessages': errorMessages,
        'statusCode': statusCode,
        'isActive' :isActive
      };

  static AppError withErrorResponse(Response error) {
    debugPrint('withErrorResponse =0=>> ${error.data}');
    debugPrint('withErrorResponse =data=>> $error}');

    final AppError response = AppError();
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

  static AppError withErrorString(String error) {
    final AppError response =  AppError();
    response.errorMessages = error;
    return response;
  }

  @override
  String toString() => 'errors: $errors errorMessages: $errorMessages statusCode: $statusCode';

}
