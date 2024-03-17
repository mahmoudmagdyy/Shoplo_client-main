import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/data_sources/auth_data_provider.dart';
import '../../../data/repositories/auth_repository.dart';
part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  static ResetPasswordCubit get(context) => BlocProvider.of(context);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  ///ResetPassword
  void resetPassword(values) async{
    String? token = await messaging.getToken();
    values['device_token'] = token;
    emit(ResetPasswordLoadingState());
    final dataProvider = AuthDataProvider();
    final AuthRepository repository = AuthRepository(dataProvider);
    repository.resetPassword(values).then(
      (value) {
        debugPrint("🚀 resetPassword cubit  ${value.toString()}");
        if (value.errorMessages != null) {
          emit(ResetPasswordErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(ResetPasswordErrorState(value.errors!));
        } else {
          emit(ResetPasswordLoadedState(value.data));
        }
      },
    );
  }
}
