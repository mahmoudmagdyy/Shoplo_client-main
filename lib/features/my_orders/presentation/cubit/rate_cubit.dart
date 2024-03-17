import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/datasources/orders_data_provider.dart';
import '../../data/repositories/orders_repository.dart';

part 'rate_state.dart';

class RateCubit extends Cubit<RateState> {
  RateCubit() : super(RateInitial());

  static RateCubit get(context) => BlocProvider.of(context);

  static final OrdersDataProvider dataProvider = OrdersDataProvider();
  static final OrdersRepository repository = OrdersRepository(dataProvider);

  void sendRate(values) {
    emit(RateLoadingState());
    repository.sendRate(values).then(
          (value) {
        debugPrint("@@@value ${value}");
        if (value.errorMessages != null) {
          emit(RateErrorState(value.errorMessages!));
        }
        else if (value.errors != null){
          emit(RateErrorState(value.errors!));
        }
        else {
          emit(const RateSuccessState());
        }
      },
    );
  }
}
