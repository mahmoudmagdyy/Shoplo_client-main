import 'package:shoplo_client/core/core_model/app_response.dart';

import '../../domain/repositories/profile_interface.dart';
import '../data_sources/profile_data_provider.dart';

class ProfileRepository extends ProfileInterFace {
  final ProfileProvider profileProvider;
  ProfileRepository(this.profileProvider);

  @override
  Future<AppResponse> getProfile() {
    return profileProvider.getProfile();
  }

  @override
  Future<AppResponse> updateProfile(values) {
    return profileProvider.updateProfile(values);
  }

  @override
  Future<AppResponse> changePassword(values, accessToken) {
    return profileProvider.changePassword(values, accessToken);
  }
}
