import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/app_pages/presentation/cubit/contact_us_cubit.dart';
import 'package:shoplo_client/features/auth/presentation/cubit/country/country_cubit.dart';
import 'package:shoplo_client/features/chat/presentation/cubit/uploader_cubit/uploader_cubit.dart';
import 'package:shoplo_client/features/home/presentation/cubit/home_cubit.dart';
import 'package:shoplo_client/features/home/presentation/cubit/map_cubit.dart';
import 'package:shoplo_client/features/home/presentation/cubit/stores_cubit.dart';
import 'package:shoplo_client/features/my_orders/presentation/cubit/rate_cubit.dart';
import 'package:shoplo_client/features/products/presentation/cubit/product_categories_cubit.dart';
import 'package:shoplo_client/widgets/reaponive_framwork_widget.dart';

import 'core/routes/app_router.dart';
import 'core/services/navigation_service.dart';
import 'features/addresses/presentation/cubit/addresses_cubit.dart';
import 'features/addresses/presentation/cubit/city/city_cubit.dart';
import 'features/addresses/presentation/cubit/country/country_cubit.dart';
import 'features/addresses/presentation/cubit/map/map_cubit.dart';
import 'features/addresses/presentation/cubit/state/state_cubit.dart';
import 'features/app_pages/presentation/cubit/app_pages_cubit.dart';
import 'features/auth/presentation/cubit/cities/cities_cubit.dart';
import 'features/auth/presentation/cubit/profile/profile_cubit.dart';
import 'features/cart/presentation/cubit/add_order_cubit.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';
import 'features/chat/presentation/cubit/chat_cubit.dart';
import 'features/home/presentation/cubit/categories_cubit.dart';
import 'features/home/presentation/cubit/location_cubit.dart';
import 'features/layout/presentation/cubit/app/app_cubit.dart';
import 'features/layout/presentation/cubit/user/user_cubit.dart';
import 'features/my_orders/presentation/cubit/cubit/order_details_cubit.dart';
import 'features/my_orders/presentation/cubit/order_cubit.dart';
import 'features/network/presentation/cubit/internet_cubit.dart';
import 'features/notification/presentation/cubit/notifications_count_cubit.dart';
import 'features/wallet/presentation/cubit/wallet_cubit.dart';
import 'resources/colors/colors.dart';
import 'resources/localization/l10n.dart';
import 'resources/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: AppColors.white));
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetConnectionCubit>(
          create: (_) => InternetConnectionCubit(),
        ),
        BlocProvider<LocationCubit>(create: (_) => LocationCubit()),
        BlocProvider<CartCubit>(create: (_) => CartCubit()..getCart({})),
        BlocProvider<MapAddressCubit>(create: (_) => MapAddressCubit()),
        BlocProvider<AddOrderCubit>(create: (_) => AddOrderCubit()),
        BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
        BlocProvider<CategoriesCubit>(create: (_) => CategoriesCubit()),
        BlocProvider<ProductCategoryCubit>(
            create: (_) => ProductCategoryCubit()),
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => WalletCubit()),
        BlocProvider(create: (context) => AppPagesCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => CountryCubit()),
        BlocProvider(create: (context) => ContactUsCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => UploaderCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => AddressesCubit()),
        BlocProvider(create: (context) => CountriesCubit()),
        BlocProvider(create: (context) => StateCubit()),
        BlocProvider(create: (context) => CityCubit()),
        BlocProvider(create: (context) => CitiesCubit()),
        BlocProvider(create: (context) => NotificationsCountCubit()),
        BlocProvider(create: (context) => MapAddressCubit()),
        BlocProvider(create: (context) => MapCubit()),
        BlocProvider(create: (context) => StoresCubit()),
        BlocProvider(create: (context) => OrderCubit()),
        BlocProvider(create: (context) => OrderDetailsCubit()),
        BlocProvider(create: (context) => RateCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppLanguageState) {
            print("asdia9sidjolkaskdmoijaskld.,");
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: MaterialApp(
              navigatorKey: NavigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'Base',
              theme: lightTheme(),
              builder: (context, child) {
                return AppResponsiveWrapper(child: child);
              },
              //darkTheme: darkTheme(),
              themeMode: AppCubit.get(context).isDarkTheme
                  ? ThemeMode.dark
                  : ThemeMode.light,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: L10n.all,
              locale: AppCubit.get(context).locale,
              initialRoute: initialRoute,
              onGenerateRoute: AppRouter.onGenerateAppRoute,
              onGenerateTitle: (context) => context.tr.app_name,
            ),
          );
        },
      ),
    );
  }
}
