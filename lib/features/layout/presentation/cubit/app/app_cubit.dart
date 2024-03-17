import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/language.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  // app language
  Locale locale = Locale(LanguageRepository.initLanguage());
  void setLang(Locale l) {
    debugPrint('==== setLang $l');
    locale = l;
    emit(AppLanguageState());
  }

  /// get the current language as string like ar ,en
  String getCurrentLanguage(context) {
    Locale myLocale = Localizations.localeOf(context);
    return myLocale.toLanguageTag();
  }

  bool isRTL(context) {
    Locale myLocale = Localizations.localeOf(context);
    // debugPrint('myLocale ' + myLocale.toLanguageTag());
    return myLocale.toLanguageTag() == 'ar';
  }

  // theme
  bool isDarkTheme = false;

  void changeAppMode() {
    isDarkTheme = !isDarkTheme;
    emit(AppChangeModeState());
  }
  // end theme

  /// Refreshing lists and details
  bool refreshOrderDetails = false;
  void setRefreshOrder() {
    refreshOrderDetails = !refreshOrderDetails;
    emit(RefreshOrderState());
  }
}
