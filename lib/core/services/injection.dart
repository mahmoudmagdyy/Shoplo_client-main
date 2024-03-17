import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplo_client/features/addresses/data/repositories/address_repository.dart';
import 'package:shoplo_client/features/auth/data/data_sources/cities_data_provider.dart';
import 'package:shoplo_client/features/auth/data/repositories/cities_repository.dart';
import 'package:shoplo_client/features/cart/data/datasources/payment_data_provider.dart';
import 'package:shoplo_client/features/cart/data/repositories/cart_repository.dart';
import 'package:shoplo_client/features/categories/data/datasources/category_data_provider.dart';
import 'package:shoplo_client/features/categories/data/repositories/categories_repository.dart';
import 'package:shoplo_client/features/chat/data/repositories/chat_repository.dart';
import 'package:shoplo_client/features/multiple_orders/data/datasources/multiple_orders_data_provider.dart';
import 'package:shoplo_client/features/my_orders/data/datasources/orders_data_provider.dart';
import 'package:shoplo_client/features/ship_by_global/data/datasources/ship_by_global_data_provider.dart';
import 'package:shoplo_client/features/ship_by_global/data/repositories/ship_by_global_repository.dart';
import 'package:shoplo_client/features/wallet/data/datasources/wallet_data_provider.dart';

import '../../features/addresses/data/data_source/address_data_provider.dart';
import '../../features/cart/data/datasources/cart_data_provider.dart';
import '../../features/cart/data/repositories/payment_repository.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/chat/data/data_sources/chat_data_provider.dart';
import '../../features/multiple_orders/data/datasources/multiple_orders_review_data_provider.dart';
import '../../features/multiple_orders/data/repositories/multiple_orders_repository.dart';
import '../../features/multiple_orders/data/repositories/multiple_orders_review_repository.dart';
import '../../features/my_orders/data/repositories/orders_repository.dart';
import '../../features/my_orders/presentation/cubit/order_cubit.dart';
import '../../features/network/presentation/cubit/internet_cubit.dart';
import '../../features/products/data/datasources/products_data_provider.dart';
import '../../features/products/data/repositories/products_repository.dart';
import '../../features/wallet/data/repositories/wallet_repository.dart';
import '../utils/logger/logger_utils.dart';

final serviceLocator = GetIt.instance;

Future<void> injectionInit() async {
  serviceLocator.allowReassignment = false;

  ///register singleTone
  // serviceLocator.registerSingleton<StorageHelper>(await StorageHelper.init());
  // serviceLocator.registerSingleton<DioHelper>(DioHelper.init());

  serviceLocator.registerSingleton<GlobalKey<ScaffoldState>>(GlobalKey<ScaffoldState>());

  ///register lazy singleTone
  serviceLocator.registerLazySingleton<LoggerUtils>(() => LoggerUtils.getInstance());
  //serviceLocator.registerLazySingleton(() => DataConnectionChecker());
  //serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(serviceLocator()));

  ///registerFactory
  serviceLocator.registerFactory(
    () => InternetConnectionCubit(),
  );
  // serviceLocator.registerFactory<AppCubit>(() => AppCubit());
  serviceLocator.registerFactory<CartCubit>(() => CartCubit());
  serviceLocator.registerFactory<OrderCubit>(() => OrderCubit());

  // repositories
  serviceLocator.registerLazySingleton(
    () => ProductsRepository(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => CartRepository(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => OrdersRepository(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => PaymentRepository(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => WalletRepository(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => ChatRepository(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => AddressRepository(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => CategoriesRepository(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => CitiesRepository(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => MultipleOrdersRepository(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => ShipByGlobalRepository(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => MultipleOrdersReviewRepository(serviceLocator()),
  );

//data sources
  serviceLocator.registerLazySingleton<ProductsDataProvider>(() => ProductsDataProvider());
  serviceLocator.registerLazySingleton<CartDataProvider>(() => CartDataProvider());
  serviceLocator.registerLazySingleton<CategoriesDataProvider>(() => CategoriesDataProvider());
  serviceLocator.registerLazySingleton<ShipByGlobalDataProvider>(() => ShipByGlobalDataProvider());
  serviceLocator.registerLazySingleton<OrdersDataProvider>(() => OrdersDataProvider());
  serviceLocator.registerLazySingleton<PaymentDataProvider>(() => PaymentDataProvider());
  serviceLocator.registerLazySingleton<WalletDataProvider>(() => WalletDataProvider());
  serviceLocator.registerLazySingleton<CitiesDataProvider>(() => CitiesDataProvider());

  serviceLocator.registerLazySingleton<AddressProvider>(() => AddressProvider());
  serviceLocator.registerLazySingleton<MultipleOrdersDataProvider>(() => MultipleOrdersDataProvider());
  serviceLocator.registerLazySingleton<MultipleOrdersReviewDataProvider>(() => MultipleOrdersReviewDataProvider());

  serviceLocator.registerLazySingleton(
    () => ChatDataProvider(),
  );
}


///used in main
// await dependency_injection.init();

///used as object
//serviceLocator<NumberTriviaBloc>()
//serviceLocator<User>().getBrandInfoModel()!.brandInfoModelReturn![0].brandId!

