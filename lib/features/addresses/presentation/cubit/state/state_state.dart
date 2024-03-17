part of 'state_cubit.dart';

@immutable
abstract class StateState extends Equatable {
  const StateState();

  @override
  List<Object> get props => [];
}

class StateInitial extends StateState {}

///get citises
class StatesLoadingStateNew extends StateState {}


class StatesErrorStateNew extends StateState {
  final String error;
  const StatesErrorStateNew(this.error);
}

class StatesSuccessStateNew extends StateState {
  final List<StateEntity> states;
  const StatesSuccessStateNew(this.states);
}

class ResetStateCubit extends StateState {}