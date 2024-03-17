import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/data_sources/auth_data_provider.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../domain/repositories/auth_statics.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());
  static LogoutCubit get(context) => BlocProvider.of(context);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// Logout
  void logout() async {
    String? token = await messaging.getToken();
    Map<String, dynamic> values = {
      'device_token': token,
    };
    debugPrint('VALUES logout: $values}', wrapWidth: 1024);
    emit(LogoutLoadingState());
    final dataProvider = AuthDataProvider();
    final AuthRepository repository = AuthRepository(dataProvider);
    repository.logout(values).then(
          (value) {
        debugPrint("🚀🚀🚀🚀🚀🚀 error  ${value.errorMessages}}");
        if (value.errorMessages != null) {
          emit(LogoutErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(LogoutErrorState(value.errors!));
        } else {
          AuthStatics.logout();
          emit(LogoutSuccessState());
        }
      },
    );
  }
}
