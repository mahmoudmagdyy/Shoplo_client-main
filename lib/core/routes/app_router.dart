import 'package:flutter/material.dart';
import 'package:shoplo_client/features/app_pages/presentation/pages/about_us.dart';
import 'package:shoplo_client/features/app_pages/presentation/pages/contact_us.dart';
import 'package:shoplo_client/features/app_pages/presentation/pages/faq.dart';
import 'package:shoplo_client/features/app_pages/presentation/pages/privacy.dart';
import 'package:shoplo_client/features/app_pages/presentation/pages/terms.dart';
import 'package:shoplo_client/features/auth/presentation/pages/change_phone.dart';
import 'package:shoplo_client/features/auth/presentation/pages/cities.dart';
import 'package:shoplo_client/features/auth/presentation/pages/forgot_password.dart';
import 'package:shoplo_client/features/auth/presentation/pages/verify_email.dart';
import 'package:shoplo_client/features/cart/presentation/pages/cart_google_store.dart';
import 'package:shoplo_client/features/cart/presentation/pages/complete_order.dart';
import 'package:shoplo_client/features/cart/presentation/pages/done_order_google_store.dart';
import 'package:shoplo_client/features/cart/presentation/pages/payment.dart';
import 'package:shoplo_client/features/home/presentation/pages/other_stores.dart';
import 'package:shoplo_client/features/home/presentation/pages/select_main_services.dart';
import 'package:shoplo_client/features/home/presentation/pages/stores_categories.dart';
import 'package:shoplo_client/features/intro/presentation/pages/intro_languge.dart';
import 'package:shoplo_client/features/intro/presentation/pages/intro_login.dart';
import 'package:shoplo_client/features/multiple_orders/domain/request/create_mutiple_order_request.dart';
import 'package:shoplo_client/features/my_orders/presentation/pages/edit_order.dart';
import 'package:shoplo_client/features/my_orders/presentation/pages/my_order.dart';
import 'package:shoplo_client/features/my_orders/presentation/pages/order_details.dart';
import 'package:shoplo_client/features/my_orders/presentation/pages/scheduled_order_details.dart';
import 'package:shoplo_client/features/notification/presentation/pages/notification.dart';
import 'package:shoplo_client/features/onboarding/presentation/screens/onboard_screen.dart';
import 'package:shoplo_client/features/onboarding/presentation/screens/start_screen.dart';
import 'package:shoplo_client/features/ship_by_global/presentation/pages/ship_by_global_list.dart';
import 'package:shoplo_client/features/ship_by_global/presentation/pages/shipping_payment.dart';
import 'package:shoplo_client/features/wallet/presentation/pages/wallet_charge_page.dart';

import '../../features/addresses/presentation/pages/add_address.dart';
import '../../features/addresses/presentation/pages/addresses.dart';
import '../../features/addresses/presentation/pages/edit_address.dart';
import '../../features/addresses/presentation/pages/map_search.dart';
import '../../features/auth/presentation/pages/change_mail.dart';
import '../../features/auth/presentation/pages/change_password.dart';
import '../../features/auth/presentation/pages/countries.dart';
import '../../features/auth/presentation/pages/done_reset_password.dart';
import '../../features/auth/presentation/pages/login.dart';
import '../../features/auth/presentation/pages/profile_account.dart';
import '../../features/auth/presentation/pages/register.dart';
import '../../features/auth/presentation/pages/reset_password.dart';
import '../../features/auth/presentation/pages/verify_forgot_password.dart';
import '../../features/auth/presentation/pages/verify_phone.dart';
import '../../features/auth/presentation/pages/verify_update_phone.dart';
import '../../features/cart/presentation/pages/cart.dart';
import '../../features/cart/presentation/pages/done_order.dart';
import '../../features/cart/presentation/pages/preview_cart_google_store.dart';
import '../../features/cart/presentation/pages/select_address.dart';
import '../../features/chat/presentation/pages/chat.dart';
import '../../features/home/data/models/place_details.dart';
import '../../features/home/presentation/pages/layout.dart';
import '../../features/layout/presentation/pages/home_layout.dart';
import '../../features/multiple_orders/presentation/pages/multiple_orders.dart';
import '../../features/multiple_orders/presentation/pages/multiple_orders_review.dart';
import '../../features/my_orders/data/models/order.dart';
import '../../features/products/data/models/product.dart';
import '../../features/products/presentation/pages/product_details.dart';
import '../../features/products/presentation/pages/products.dart';
import '../../features/ship_by_global/presentation/pages/ship_by_global.dart';
import '../../features/ship_by_global/presentation/pages/ship_by_global_view.dart';
import '../../features/wallet/presentation/pages/wallet.dart';
import '../services/navigation_service.dart';
import 'app_routes.dart';

class AppRouter {
  static String routeName = '';
  static Route<dynamic> onGenerateAppRoute(RouteSettings settings) {
    debugPrint('App route =========== > $settings.name');
    debugPrint('App route =========== > $settings.arguments');
    NavigationService().setRouteName(settings.name!);
    routeName = settings.name!;

    switch (settings.name) {
      ///intro
      case AppRoutes.introLanguage:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const IntroLanguage();
          },
          settings: settings,
        );
        case AppRoutes.startScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const StartScreen();
          },
        );
        case AppRoutes.doneResetPassword:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const DoneResetPassword();
          },
        );
        case AppRoutes.onBoardingRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return  OnboardingScreen();
          },
          settings: settings,
        );

      case AppRoutes.introLogin:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const IntroLogin();
          },
          settings: settings,
        );
      case AppRoutes.otherStores:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const OtherStoresScreen();
          },
          settings: settings,
        );
        case AppRoutes.layout:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return  Layout();
          },
          settings: settings,
        );

      ///home
      case AppRoutes.appHome:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return HomeLayout(
              inApp: settings.arguments != null ? true : false,
            );
          },
          settings: settings,
        );

      case AppRoutes.countries:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const Countries();
          },
          settings: settings,
        );
      case AppRoutes.selectMainService:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const SelectMainService();
          },
          settings: settings,
        );
      case AppRoutes.storesCategories:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const StoreCategories();
          },
          settings: settings,
        );

      case AppRoutes.cities:
        final countryDetails = settings.arguments as Map;
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return Cities(
              countryId: countryDetails['countryId'],
              countryName: countryDetails['countryName'],
            );
          },
          settings: settings,
        );

      ///Auth
      case AppRoutes.login:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const LoginScreen();
          },
          settings: settings,
        );

      case AppRoutes.register:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const RegisterScreen();
          },
          settings: settings,
        );

      case AppRoutes.verifyPhone:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            final arguments = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            return VerifyPhone(
              phone: arguments["phone"],
              countryCode: arguments["countryCode"],
            );
          },
          settings: settings,
        );

      case AppRoutes.verifyUpdatePhone:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            final arguments = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            return VerifyUpdatePhone(
              phone: arguments["phone"],
              countryCode: arguments["countryCode"],
            );
          },
          settings: settings,
        );

      case AppRoutes.verifyForgotPassword:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            final arguments = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            return VerifyForgotPassword(
              phone: arguments["phone"],
              countryCode: arguments["countryCode"],
            );
          },
          settings: settings,
        );

      case AppRoutes.changeEmail:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ChangeEmail();
          },
          settings: settings,
        );

      case AppRoutes.verifyEmail:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const VerifyEmail();
          },
          settings: settings,
        );

      case AppRoutes.changePhone:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ChangePhone();
          },
          settings: settings,
        );

      case AppRoutes.forgotPassword:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ForgotPassword();
          },
          settings: settings,
        );

      case AppRoutes.resetPassword:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            final arguments = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            return ResetPassword(
              phone: arguments["phone"],
              countryCode: arguments["countryCode"],
              token: arguments["token"],
            );
          },
          settings: settings,
        );

      case AppRoutes.changePassword:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ChangePassword();
          },
          settings: settings,
        );

      ///profile
      case AppRoutes.editAccount:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ProfileAccount();
          },
          settings: settings,
        );

      ///AppPages
      case AppRoutes.aboutUsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const AboutUsScreen();
          },
          settings: settings,
        );
      case AppRoutes.terms:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const TermsScreen();
          },
          settings: settings,
        );

      case AppRoutes.faq:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const FaqScreen();
          },
          settings: settings,
        );
      case AppRoutes.contactUs:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ContactUsScreen();
          },
          settings: settings,
        );

      case AppRoutes.privacy:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const PrivacyScreen();
          },
          settings: settings,
        );

      ///Notification
      case AppRoutes.notification:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const NotificationScreen();
          },
          settings: settings,
        );

      /// cart
      case AppRoutes.cartScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const CartScreen();
          },
          settings: settings,
        );

      case AppRoutes.paymentScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            final arguments = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            return PaymentScreen(
              orderData: arguments['orderData'],
              previewOrder: arguments['previewOrder'],
            );
          },
          settings: settings,
        );
      case AppRoutes.completeOrderScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return CompleteOrderScreen(
                orderData: settings.arguments as Map<String, String>);
          },
          settings: settings,
        );
      case AppRoutes.doneOrderScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return DoneOrderScreen(order: settings.arguments as OrderModel);
          },
          settings: settings,
        );
      case AppRoutes.cartGoogleStoreScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return CartGoogleStoreScreen(
                store: settings.arguments as PlaceDetails);
          },
          settings: settings,
        );
      case AppRoutes.previewCartGoogleStoreScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return PreviewCartGoogleStoreScreen(
                orderData: settings.arguments as Map<String, String>);
          },
          settings: settings,
        );

      case AppRoutes.doneOrderGoogleStoreScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const DoneOrderGoogleStoreScreen();
          },
          settings: settings,
        );

      case AppRoutes.selectAddressScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const SelectAddressesScreen();
          },
          settings: settings,
        );

      /// Wallet
      case AppRoutes.walletScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const WalletScreen();
          },
          settings: settings,
        );
      case AppRoutes.walletChargeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const WalletChargePage();
          },
          settings: settings,
        );

      /// Products
      case AppRoutes.productsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return ProductsScreen(store: settings.arguments as PlaceDetails);
          },
          settings: settings,
        );

      case AppRoutes.productDetailsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return ProductDetails(product: settings.arguments as ProductModel);
          },
          settings: settings,
        );

      ///chat
      case AppRoutes.chatScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            final arguments = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            return ChatScreen(
              orderId: arguments["orderId"],
              deliveryName: arguments["deliveryName"],
            );
            //final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            // return ChatScreen(
            //   message: arguments["message"] as Message,
            //   fromRequestChat:  arguments["fromRequestChat"]! as bool,
            // );
          },
          settings: settings,
        );

      ///myOrder
      case AppRoutes.myOrder:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const MyOrderScreen();
          },
          settings: settings,
        );

      case AppRoutes.orderDetails:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            final arguments = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            return OrderDetails(
              orderId: arguments["orderId"],
            );
          },
          settings: settings,
        );

      case AppRoutes.editOrder:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            final arguments = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            return EditOrder(
              orderId: arguments["orderId"],
            );
          },
          settings: settings,
        );

      case AppRoutes.addresses:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const AddressesScreen();
          },
          settings: settings,
        );

      case AppRoutes.addAddress:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const AddAddressScreen();
          },
          settings: settings,
        );

      case AppRoutes.editAddress:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            final arguments = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            return EditAddress(
              id: arguments["id"],
            );
          },
          settings: settings,
        );
      case AppRoutes.multipleOrdersScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const MultipleOrdersScreen();
          },
          settings: settings,
        );
      case AppRoutes.multipleOrdersReview:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return MultipleOrdersReviewScreen(
                createRequest:
                    settings.arguments as CreateMultipleOrderRequest);
          },
          settings: settings,
        );
      case AppRoutes.multipleOrdersDetails:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            final arguments = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            return ScheduledOrderDetails(
              orderId: arguments["orderId"],
            );
          },
          settings: settings,
        );

      case AppRoutes.mapSearchScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return MapSearchScreen(
              latLng: (settings.arguments as Map)['LatLng'],
              country: (settings.arguments as Map)['country'],
            );
          },
          settings: settings,
        );

      case AppRoutes.shipByGlobalScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ShipByGlobalScreen();
          },
          settings: settings,
        );
      case AppRoutes.shipByGlobalView:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return ShipByGlobalView(orderId: settings.arguments as int);
          },
          settings: settings,
        );
      case AppRoutes.shipByGlobalList:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ShipByGlobalScreenList();
          },
          settings: settings,
        );
      case AppRoutes.shippingPaymentScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return ShippingPaymentScreen(
                orderId: (settings.arguments as Map)['orderId'],
                total: (settings.arguments as Map)['total']);
          },
          settings: settings,
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("no routes founded"),
              ),
              body: const Center(child: Text("no routes founded")),
            ));
  }
}
