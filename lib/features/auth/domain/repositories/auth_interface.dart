import '../../../../core/core_model/app_response.dart';

abstract class AuthInterface {
  Future<AppResponse> register(Map<String, dynamic> values);
  Future<AppResponse> login(Map<String, dynamic> values);
  Future<AppResponse> verifyCode(values);
  Future<AppResponse> resendCode(values);
  Future<AppResponse> verifyUpdatePhone(values);
  Future<AppResponse> logout(Map<String, dynamic> values);
  Future<AppResponse> forgetPassword(values);
  Future<AppResponse> verifyToken(values, accessToken);
  Future<AppResponse> resetPassword(values);
  Future<AppResponse> deleteAccount(values);
}
