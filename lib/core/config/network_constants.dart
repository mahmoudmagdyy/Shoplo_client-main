class NetworkConstants {
  NetworkConstants._();

  ///Base Url
  ///
  //static const String baseUrl =  'https://shoplo.fudex-tech.net/shopLo-backend/public/';//demo
  static const String baseUrl ='https://cc-gs.com/shopLo-backend/public/'; //live
  static const String apiPrefix = '/api';

  ///End Points
  ///appPages
  static const String terms = '/pages/terms';
  static const String aboutUs = '/pages/about-us';
  static const String privacy = '/pages/policy';
  static const String contactUsTypes = '/contact-types';
  static const String contactUs = '/contact-us';

  ///Auth
  static const String countries = '/location/countries';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verifyAccount = '/auth/verify-account';
  static const String resendCode = '/auth/resend-verification-code';
  static const String logout = '/auth/logout';
  static const String forgotPassword = '/auth/forget-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyForgotPassword = '/auth/verify-token';
  static const String verifyUpdatePhone = '/profile/verify-phone';
  static const String deleteAccount = '/auth/delete-account';
  static const String changeCountry = '/auth/change-country';

  ///profile
  static const String profile = '/profile';
  static const String addresses = '/profile/user-addresses';
  static const String changePassword = '/profile/change-password';

  ///dropdown
  static const String dropDownCountries = '/location/countries';
  static const String dropDownStates = '/location/states';
  static const String dropDownCites = '/location/cities';

  /// Chat
  static const String chat = '/chats';
  static const String sendChat = '/chats/send';

  /// Cart
  static const String cart = '/cart';

  // wallet
  static const String userTransactions = '/user-transactions';

  /// Stores
  static const String categories = '/categories';
  static const String stores = '/stores';
  static const String storesProducts = '/products';

  /// Stores
  static const String orders = '/orders';
  static const String shippings = '/shippings';
  static const String shippingPayment = '/payment';
  static const String ordersPreview = '/orders/preview';

  static const String changeOrderStatus = '/change-status';
  static const String changeShippingStatus = '/accept-reject-shipping';
  static String acceptRejectScheduled(id) => '/orders/$id/accept-reject-scheduled';

  /// payment
  static const String paymentMethods = '/payment-methods';
  static const String onlineMethods = '/online-payment-methods';
  static const String previewOrder = '/orders/preview';
  static const String checkCoupon = '/check-coupon';
  static const String banks = '/bank-accounts';
  static const String banksTransfer = '/user/transfer';

  /// uploader
  static const String uploader = '/uploader';
  static const String multipleUploader = '/uploader/multiple-files';

  ///Rate
  static const String rate = '/ratings';

  ///notification
  static const String notification = '/user-notifications';
  static const String notificationCount = '/user-notifications/count';
}
