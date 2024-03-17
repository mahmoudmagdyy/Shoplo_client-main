part of 'addresses_cubit.dart';

abstract class AddressesState extends Equatable {
  const AddressesState();

  @override
  List<Object> get props => [];
}

class AddressesInitial extends AddressesState {}

///
class GetAddressesLoadingState extends AddressesState {}

class GetAddressesLoadingNextPageState extends AddressesState {}

class GetAddressesSuccessState extends AddressesState {
  final List<AddressModel> addresses;
  const GetAddressesSuccessState(this.addresses);
}

class GetAddressesErrorState extends AddressesState {
  final String error;
  const GetAddressesErrorState(this.error);
}

///
class GetAddressesDetailsLoadingState extends AddressesState {}

class GetAddressesDetailsLoadingNextPageState extends AddressesState {}

class GetAddressesDetailsSuccessState extends AddressesState {
  final AddressModel addresses;
  const GetAddressesDetailsSuccessState(this.addresses);
}

class GetAddressesDetailsErrorState extends AddressesState {
  final String error;
  const GetAddressesDetailsErrorState(this.error);
}

///
class AddAddressesLoadingState extends AddressesState {}

class AddAddressesLoadingNextPageState extends AddressesState {}

class AddAddressesSuccessState extends AddressesState {
  final String message;
  const AddAddressesSuccessState(this.message);
}

class AddAddressesErrorState extends AddressesState {
  final String error;
  const AddAddressesErrorState(this.error);
}

///
class EditAddressesLoadingState extends AddressesState {}

class EditAddressesLoadingNextPageState extends AddressesState {}

class EditAddressesSuccessState extends AddressesState {
  final AddressModel address;
  const EditAddressesSuccessState(this.address);
}

class EditAddressesErrorState extends AddressesState {
  final String error;
  const EditAddressesErrorState(this.error);
}

class DeleteAddressesLoadingState extends AddressesState {}

class DeleteAddressesLoadingNextPageState extends AddressesState {}

class DeleteAddressesSuccessState extends AddressesState {
  final String message;
  const DeleteAddressesSuccessState(this.message);
}

class DeleteAddressesErrorState extends AddressesState {
  final String error;
  const DeleteAddressesErrorState(this.error);
}
