import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/user_data.dart';
import '../../../data/data_sources/auth_data_provider.dart';
import '../../../data/repositories/auth_repository.dart';

part 'verify_account_state.dart';

class VerifyAccountCubit extends Cubit<VerifyAccountState> {
  VerifyAccountCubit() : super(VerifyAccountInitial());
  static VerifyAccountCubit get(context) => BlocProvider.of(context);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  //Verify
  void verifyCode(values) async {
    String? token = await messaging.getToken();
    values['device_token'] = token;
    emit(VerifyLoadingState());
    final dataProvider = AuthDataProvider();
    final AuthRepository repository = AuthRepository(dataProvider);
    repository.verifyCode(values).then(
          (value) {
        if (value.errorMessages != null) {
          emit(VerifyErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(VerifyErrorState(value.errors!));
        } else {
          if (value.data["user"] != null) {
            debugPrint("@@@@@!1${value.data}");
            emit(VerifyUserLoadedState(UserDataModel.fromJson(value.data)));
            debugPrint("@@@@@!2");
          } else {
            emit(VerifyLoadedState(value.data));
          }
        }
      },
    );
  }

  ///Resend
  void resendCode(values) {
    emit(ResendLoadingState());
    final dataProvider = AuthDataProvider();
    final AuthRepository repository = AuthRepository(dataProvider);
    repository.resendCode(values).then(
          (value) {
        if (value.errorMessages != null) {
          emit(ResendErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(ResendErrorState(value.errors!));
        } else {
          emit(ResendLoadedState(value.data));
        }
      },
    );
  }

}
