import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/network_constants.dart';
import 'custom_interceptors.dart';

class DioHelper {
  static late Dio dio;
  static const String baseUrl = NetworkConstants.baseUrl + NetworkConstants.apiPrefix;

  static init({String lang = 'en', String accessToken = ''}) {
    debugPrint('accessToken in init dio =>>$accessToken');
    var options = BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: baseUrl,
      headers: {
        'Accept-Language': lang,
        'Authorization': "Bearer $accessToken",
        'Content-Type': 'application/json',
        'Accept': 'application/json',

        // 'Content-Type': 'multipart/form-data'
      },
      // connectTimeout: 20000,
      // receiveTimeout: 20000,
    );

    dio = Dio(options);
    dio.interceptors.add(CustomInterceptors());
    // ..add(LogInterceptor());
    // ..add(LogInterceptor(requestHeader: false, responseHeader: false));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    debugPrint('dataaaaaa ================================ $data');

    return dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    return dio.put(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> postFormData(
      {required String url,
      required Map<String, dynamic> data,
      Map<String, dynamic>? query,
      String? accessToken,
      Function(int, int)? onSendProgress}) async {
    var formData = FormData.fromMap(data);
    debugPrint('formData ================================ ${formData.fields}');
    debugPrint('accessToken-->>  $accessToken');
    if (accessToken != '' && accessToken != null) {
      debugPrint('enter');
      dio.options.headers["Authorization"] = "Bearer $accessToken";
    }
    return dio.post(
      url,
      data: formData,
      queryParameters: query,
      onSendProgress: onSendProgress,
    );
  }

  static Future<Response> patch({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? accessToken,
  }) async {
    //var formData = FormData.fromMap(data);
    //debugPrint('formData ================================ ${formData.fields}');
    debugPrint('accessToken  $accessToken');
    if (accessToken != '' && accessToken != null) {
      debugPrint('enter');
      dio.options.headers["Authorization"] = "Bearer $accessToken";
    }
    return dio.patch(
      url,
      data: data,
      // queryParameters: query,
    );
  }

  static Future<Response> deleteData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    return dio.delete(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
