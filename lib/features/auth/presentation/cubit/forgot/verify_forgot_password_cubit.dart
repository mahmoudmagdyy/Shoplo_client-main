import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoplo_client/features/auth/data/models/user_data.dart';
import 'package:shoplo_client/features/auth/domain/entities/user_data.dart';

import '../../../data/data_sources/auth_data_provider.dart';
import '../../../data/repositories/auth_repository.dart';

part 'verify_forgot_password_state.dart';

class VerifyForgotPasswordCubit extends Cubit<VerifyForgotPasswordState> {
  VerifyForgotPasswordCubit() : super(VerifyForgotPasswordInitial());

  static VerifyForgotPasswordCubit get(context) => BlocProvider.of(context);
  static final dataProvider = AuthDataProvider();
  static final AuthRepository repository = AuthRepository(dataProvider);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  ///Verify token
  void verifyToken(values) async {
    String? token = await messaging.getToken();
    values['device_token'] = token;
    debugPrint('VALUES: $values}', wrapWidth: 1024);
    emit(VerifyTokenLoadingState());
    repository.verifyToken(values, token).then(
          (value) {
        if (value.errorMessages != null) {
          emit(VerifyTokenErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(VerifyTokenErrorState(value.errors!));
        } else {
          emit(VerifyTokenLoadedState(value.data));
        }
      },
    );
  }

  ///Resend
  void resendCode(values) {
    emit(ResendResetLoadingState());
    final dataProvider = AuthDataProvider();
    final AuthRepository repository = AuthRepository(dataProvider);
    repository.resendCode(values).then(
          (value) {
        if (value.errorMessages != null) {
          emit(ResendResetErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(ResendResetErrorState(value.errors!));
        } else {
          emit(ResendResetLoadedState(value.data));
        }
      },
    );
  }

}
