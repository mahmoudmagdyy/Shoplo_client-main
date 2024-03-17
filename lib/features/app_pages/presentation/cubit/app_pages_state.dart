part of 'app_pages_cubit.dart';

abstract class AppPagesState extends Equatable {
  const AppPagesState();

  @override
  List<String> get props => [];
}

class AppPagesInitial extends AppPagesState {}

// terms states

class TermsAndConditionsLoadingState extends AppPagesState {}

class TermsAndConditionsSuccessState extends AppPagesState {
  final AppPagesModel terms;
  const TermsAndConditionsSuccessState(this.terms);
}

class TermsAndConditionsErrorState extends AppPagesState {
  final String error;
  const TermsAndConditionsErrorState(this.error);
}

// privacy states

class PrivacyLoadingState extends AppPagesState {}

class PrivacySuccessState extends AppPagesState {
  final AppPagesModel privacy;
  const PrivacySuccessState(this.privacy);
}

class PrivacyErrorState extends AppPagesState {
  final String error;
  const PrivacyErrorState(this.error);
}

// About us states

class AboutUsLoadingState extends AppPagesState {}

class AboutUsSuccessState extends AppPagesState {
  final AppPagesModel aboutUs;
  const AboutUsSuccessState(this.aboutUs);
}

class AboutUsErrorState extends AppPagesState {
  final String error;
  const AboutUsErrorState(this.error);
}



// App settings states

class AppSettingsLoadingState extends AppPagesState {}

class AppSettingsSuccessState extends AppPagesState {
  final List<Map<String, dynamic>> appSettings;
  const AppSettingsSuccessState(this.appSettings);
}

class AppSettingsErrorState extends AppPagesState {
  final String error;
  const AppSettingsErrorState(this.error);
}

// use app states

class UseAppLoadingState extends AppPagesState {}

class UseAppSuccessState extends AppPagesState {
  final AppPagesModel useApp;
  const UseAppSuccessState(this.useApp);
}

class UseAppErrorState extends AppPagesState {
  final String error;
  const UseAppErrorState(this.error);
}

// FAQ states

class FAQLoadingState extends AppPagesState {}

class FAQLoadingNextPageState extends AppPagesState {}

class FAQSuccessState extends AppPagesState {
  final List<FaqModel> faq;
  const FAQSuccessState(this.faq);
}

class FAQErrorState extends AppPagesState {
  final String error;
  const FAQErrorState(this.error);
}
