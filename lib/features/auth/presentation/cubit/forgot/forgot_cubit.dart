import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/data_sources/auth_data_provider.dart';
import '../../../data/repositories/auth_repository.dart';

part 'forgot_state.dart';

class ForgotCubit extends Cubit<ForgotState> {
  ForgotCubit() : super(ForgotInitial());

  static ForgotCubit get(context) => BlocProvider.of(context);
  static final dataProvider = AuthDataProvider();
  static final AuthRepository repository = AuthRepository(dataProvider);

  ///ForgetPassword
  void forgetPassword(values) {
    emit(ForgetPasswordLoadingState());
    repository.forgetPassword(values).then(
          (value) {
        debugPrint("🚀 forgetPassword cubit  ${value.toString()}");
        if (value.errorMessages != null) {
          emit(ForgetPasswordErrorState(value.errorMessages!, value.statusCode!));
        } else if (value.errors != null) {
          emit(ForgetPasswordErrorState(value.errors!, value.statusCode!));
        } else {
          emit(ForgetPasswordLoadedState(value.data));
        }
      },
    );
  }

}
