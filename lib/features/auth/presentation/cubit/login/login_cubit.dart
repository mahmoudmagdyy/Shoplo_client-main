import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_sources/auth_data_provider.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../domain/entities/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  ///Login
  void login(Map<String, dynamic> values) async {
    String? token = await messaging.getToken();
    values['device_token'] = token;
    debugPrint('VALUES: $values}', wrapWidth: 1024);
    emit(LoginLoadingState());
    final dataProvider = AuthDataProvider();
    final AuthRepository repository = AuthRepository(dataProvider);
    repository.login(values).then(
      (value) {
        //selectedIndex = 0;
        debugPrint("🚀 login cubit  ${value.toString()}");
        if (value.errorMessages != null) {
          emit(LoginErrorState(value.errorMessages!, value.statusCode!));
        } else if (value.errors != null) {
          emit(LoginErrorState(value.errors!, value.statusCode!));
        } else {
          emit(LoginLoadedState(value.data.user, value.data.accessToken));
        }
      },
    );
  }
}
