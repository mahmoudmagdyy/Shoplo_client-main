part of 'contact_us_cubit.dart';

abstract class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object> get props => [];
}

class ContactUsInitial extends ContactUsState {}

class ContactUsLoadingState extends ContactUsState {}

class ContactUsSuccessState extends ContactUsState {
  const ContactUsSuccessState();
}

class ContactUsErrorState extends ContactUsState {
  final String error;
  const ContactUsErrorState(this.error);
}

class ContactTypesLoadingState extends ContactUsState {}

class ContactTypesSuccessState extends ContactUsState {
  final List<ComplainTypeModel> contactTypes;
  const ContactTypesSuccessState(this.contactTypes);
}

class ContactTypesErrorState extends ContactUsState {
  final String error;
  const ContactTypesErrorState(this.error);
}


// About us states

class ContactUsTypesUsLoadingState extends ContactUsState {}

class ContactUsTypesSuccessState extends ContactUsState {
  const ContactUsTypesSuccessState();
}

class ContactUsTypesErrorState extends ContactUsState {
  final String error;
  const ContactUsTypesErrorState(this.error);
}