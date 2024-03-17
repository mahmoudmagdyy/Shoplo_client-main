part of 'profile_cubit.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

///get profile states
class GetProfileLoadingState extends ProfileState {}

class GetProfileErrorState extends ProfileState {
  final String error;
  const GetProfileErrorState(this.error);
}

class GetProfileLoadedState extends ProfileState {
  final User useEntity;
  const GetProfileLoadedState(this.useEntity);
}


// update profile states

class UpdateProfileLoadingState extends ProfileState {}

class UpdateProfileLoadedState extends ProfileState {
  final User userEntity ;
  const UpdateProfileLoadedState(this.userEntity);
}

class UpdateProfileLoadedPhoneEditedState extends ProfileState {
  const UpdateProfileLoadedPhoneEditedState();
}

class UpdateProfileErrorState extends ProfileState {
  final String error;
  const UpdateProfileErrorState(this.error);
}
