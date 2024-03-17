import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/dio_helper.dart';
import '../../../../core/helpers/storage_helper.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../layout/domain/repositories/language.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';

class AuthStatics {
  static void logout() async {
    debugPrint('log out === ***************************************>');

    String initLanguage = LanguageRepository.initLanguage();
    DioHelper.init(lang: initLanguage, accessToken: '');
    await AwesomeNotifications().cancelAll();
    UserCubit cubit =
        UserCubit.get(NavigationService.navigatorKey.currentContext!);
    cubit.setUser(null);
    await StorageHelper.remove(key: 'userData');
    await StorageHelper.remove(key: 'selectedCity');
    await StorageHelper.remove(key: 'enteredBefore');
    debugPrint('########################## logout ');
  }
}
