part of 'rate_cubit.dart';

@immutable
abstract class RateState extends Equatable {
  const RateState();

  @override
  List<Object> get props => [];
}


class RateInitial extends RateState {}


class RateLoadingState extends RateState {}

class RateSuccessState extends RateState {
  const RateSuccessState();
}

class RateErrorState extends RateState {
  final String error;
  const RateErrorState(this.error);
}
