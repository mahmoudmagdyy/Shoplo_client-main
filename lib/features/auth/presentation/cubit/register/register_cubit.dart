import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/data_sources/auth_data_provider.dart';
import '../../../data/repositories/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  ///Register
  void register(Map<String, dynamic> values) async {
    String? token = await messaging.getToken();
    values['device_token'] = token;
    debugPrint('VALUES: $values}');
    emit(RegisterLoadingState());
    final dataProvider = AuthDataProvider();
    final AuthRepository repository = AuthRepository(dataProvider);
    repository.register(values).then(
          (value) {
        debugPrint("🚀 value  $value}");
        if (value.errorMessages != null) {
          emit(RegisterErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(RegisterErrorState(value.errors!));
        } else {
          emit(RegisterLoadedState(value.data));
        }
      },
    );
  }
}
