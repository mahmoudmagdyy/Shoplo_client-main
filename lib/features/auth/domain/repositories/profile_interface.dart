import '../../../../core/core_model/app_response.dart';

abstract class ProfileInterFace {
  Future<AppResponse> getProfile();
  Future<AppResponse> updateProfile(values);
  Future<AppResponse> changePassword(values,accessToken);
}