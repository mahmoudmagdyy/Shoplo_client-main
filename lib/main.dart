import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoplo_client/core/services/injection.dart';

import 'core/helpers/currency_helper.dart';
import 'core/helpers/dio_helper.dart';
import 'core/helpers/storage_helper.dart';
import 'core/routes/app_routes.dart';
import 'core/services/bloc_observer.dart';
import 'features/auth/data/models/user_data.dart';
import 'features/layout/domain/repositories/language.dart';
import 'firebase_options.dart';
import 'my_app.dart';
import 'resources/colors/colors.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Fire store,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (Platform.isIOS) {
    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  // create notification channel to handle notifications
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Basic Notifications Description',
        defaultColor: AppColors.primaryL,
        ledColor: AppColors.secondaryL,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
      ),
    ],
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await injectionInit();

  await StorageHelper.init();
  Bloc.observer = MyBlocObserver();

  String initialRoute = AppRoutes.login;
  String initLanguage = LanguageRepository.initLanguage();
  String accessToken = '';

  if (StorageHelper.getData(key: 'lang') == null) {
    initialRoute = AppRoutes.introLanguage;
    LanguageRepository.setLangData(initLanguage);
  } else if (StorageHelper.getData(key: "selectedCity") == null) {
    CurrencyHelper.currency = StorageHelper.getData(
      key: 'currency',
    );
    initialRoute = AppRoutes.countries;
  } else if (StorageHelper.getObject(key: 'userData') != false) {
    UserDataModel userData = UserDataModel.fromJson(StorageHelper.getObject(key: 'userData'));
    debugPrint('userData==> ${userData.user.toString()}');
    debugPrint('accessToken==> ${userData.accessToken.toString()}');
    if (userData.toJson().isNotEmpty && userData.user.isActive) {
      initialRoute = AppRoutes.selectMainService;
      accessToken = userData.accessToken;
    } else {
      initialRoute = AppRoutes.login;
    }
  }

  DioHelper.init(lang: initLanguage, accessToken: accessToken);
  runApp(MyApp(
    initialRoute: AppRoutes.onBoardingRoute,
  ));
}

//test github again
