import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/features/auth/data/models/user_data.dart';

import '../../../../../core/helpers/dio_helper.dart';
import '../../../../../core/helpers/storage_helper.dart';
import '../../../../../core/services/navigation_service.dart';
import '../../../../layout/domain/repositories/language.dart';
import '../../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../../data/data_sources/profile_data_provider.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../domain/entities/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);

  final dataProvider = ProfileProvider();

  ///get Profile
  void getProfile() {
    emit(GetProfileLoadingState());
    final ProfileRepository repository = ProfileRepository(dataProvider);
    repository.getProfile().then(
      (value) async {
        debugPrint("🚀  get profile cubit  ${value.toString()}");
        if (value.errorMessages != null) {
          emit(GetProfileErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetProfileErrorState(value.errors!));
        } else {
          emit(GetProfileLoadedState(value.data));
        }
      },
    );
  }

  ///Update Profile
  void updateProfile(values, accessToken) {
    final ProfileRepository repository = ProfileRepository(dataProvider);
    emit(UpdateProfileLoadingState());
    repository.updateProfile(values).then(
      (value) async {
        debugPrint("🚀 update profile cubit  ${value.toString()}");

        if (value.errorMessages != null) {
          emit(UpdateProfileErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(UpdateProfileErrorState(value.errors!));
        } else {
          if (value.phoneUpdated!) {
            debugPrint("print phone dated = > phoneUpdated ");
            emit(const UpdateProfileLoadedPhoneEditedState());
          } else {
            UserCubit.get(NavigationService.navigatorKey.currentContext!).setUser(UserDataModel(user: value.data, accessToken: accessToken));
            await StorageHelper.saveObject(
              key: 'userData',
              object: UserDataModel(
                accessToken: accessToken,
                user: User(
                  id: value.data.id,
                  name: value.data.name,
                  email: value.data.email,
                  phone: value.data.phone,
                  avatar: value.data.avatar,
                  isActive: value.data.isActive,
                  addresses: value.data.addresses,
                  countryCode: value.data.countryCode,
                  createdAt: value.data.createdAt,
                  gender: value.data.gender,
                  lastLoginAt: value.data.lastLoginAt,
                  wallet: value.data.wallet,
                  type: value.data.type,
                  verificationCode: value.data.verificationCode,
                ),
              ),
            );
            String initLanguage = LanguageRepository.initLanguage();
            DioHelper.init(lang: initLanguage, accessToken: accessToken as String);
            debugPrint("🚀 update profile cubit UpdateProfileLoadedState ${value.data.toString()}");
            emit(UpdateProfileLoadedState(value.data));
          }
        }
      },
    );
  }
}
