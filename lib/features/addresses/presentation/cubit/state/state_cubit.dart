import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/method_helper.dart';
import '../../../data/data_source/address_data_provider.dart';
import '../../../data/repositories/address_repository.dart';
import '../../../domain/entities/state.dart';

part 'state_state.dart';

class StateCubit extends Cubit<StateState> {
  StateCubit() : super(StateInitial());

  static StateCubit get(context) => BlocProvider.of(context);
  static final addressProvider = AddressProvider();
  static final AddressRepository dropDownDataRepository =
  AddressRepository(addressProvider);

  ///getStates
  StateEntity? statesModel;
  void setSelectedStatesModel(StateEntity? type) {
    statesModel = type;
  }

  List<StateEntity> states = [];
  void getStates(id, {query}) {
    emit(StatesLoadingStateNew());
    dropDownDataRepository.getStates(id, query).then(
      (value) {
        if (value.errorMessages != null) {
          emit(StatesErrorStateNew(value.errorMessages!));
        } else if (value.errors != null) {
          emit(StatesErrorStateNew(value.errors!));
        } else {
          states = [];
          statesModel = null;
          debugPrint('VALUE xxxxx xxx: ${value.data}', wrapWidth: 1024);
          value.data.forEach((item) {
            states.add(StateEntity.fromJson(item));
          });
          emit(StatesSuccessStateNew(states));
        }
      },
    );
  }

  void resetCubit() {
    emit(ResetStateCubit());
    states = [];
    statesModel = null;
  }

  void setStateModel(int stateId) {
    statesModel = (states.isNotEmpty)
        ? states[getIndex(states, stateId)]
        : null;
  }

}
