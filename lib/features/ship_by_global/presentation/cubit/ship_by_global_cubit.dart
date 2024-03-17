import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/services/injection.dart';
import 'package:shoplo_client/features/categories/data/models/categories_model.dart';
import 'package:shoplo_client/features/categories/data/repositories/categories_repository.dart';
import 'package:shoplo_client/features/my_orders/data/models/order.dart' hide City, Country;
import 'package:shoplo_client/features/ship_by_global/domain/entities/ship_by_global.dart';

import '../../../addresses/data/repositories/address_repository.dart';
import '../../../addresses/domain/entities/city.dart';
import '../../../addresses/domain/entities/country.dart';
import '../../../addresses/domain/entities/state.dart';
import '../../data/repositories/ship_by_global_repository.dart';

part 'ship_by_global_state.dart';

class ShipByGlobalCubit extends Cubit<ShipByGlobalState> {
  ShipByGlobalCubit() : super(ShipByGlobalInitial());

  static ShipByGlobalCubit get(context) => BlocProvider.of(context);

  final repository = serviceLocator.get<ShipByGlobalRepository>();
  final addressRepo = serviceLocator.get<AddressRepository>();
  final categoriesRepo = serviceLocator.get<CategoriesRepository>();

  Future<List<Country>?> geCountry() async {
    final result = await addressRepo.getCountries({});
    if (result.errorMessages != null) {
      emit(ShipByGlobalErrorState(result.errorMessages!));
    } else if (result.errors != null) {
      emit(ShipByGlobalErrorState(result.errors!));
    } else {
      List<Country> states = [];
      result.data!.forEach((element) {
        states.add(Country.fromJson(element));
      });
      return states;
    }
    return null;
  }

  Future<List<StateEntity>?> getStates(int country) async {
    final result = await addressRepo.getStates(country, {});
    if (result.errorMessages != null) {
      emit(ShipByGlobalErrorState(result.errorMessages!));
    } else if (result.errors != null) {
      emit(ShipByGlobalErrorState(result.errors!));
    } else {
      List<StateEntity> states = [];
      result.data!.forEach((element) {
        states.add(StateEntity.fromJson(element));
      });
      return states;
    }
    return null;
  }

  Future<List<City>?> getCity(int country) async {
    final result = await addressRepo.getCities(country, {});
    if (result.errorMessages != null) {
      emit(ShipByGlobalErrorState(result.errorMessages!));
    } else if (result.errors != null) {
      emit(ShipByGlobalErrorState(result.errors!));
    } else {
      List<City> cites = [];
      result.data!.forEach((element) {
        cites.add(City.fromJson(element));
      });
      return cites;
    }
    return null;
  }

  Future<List<Category>?> getCategories() async {
    final result = await categoriesRepo.getCategories({"type": "shippings"});
    if (result.errorMessages != null) {
      emit(ShipByGlobalErrorState(result.errorMessages!));
    } else if (result.errors != null) {
      emit(ShipByGlobalErrorState(result.errors!));
    } else {
      List<Category> categories = [];
      result.data!.forEach((element) {
        categories.add(Category.fromJson(element));
      });
      return categories;
    }
    return null;
  }

  Future<void> addShipByGlobal(ShipByGlobalEntity data) async {
    emit(ShipByGlobalLoadingState());
    final result = await repository.addShipping(data.toJson());
    if (result.errorMessages != null) {
      emit(ShipByGlobalErrorState(result.errorMessages!));
    } else if (result.errors != null) {
      emit(ShipByGlobalErrorState(result.errors!));
    } else {
      emit(ShipByGlobalSuccessState(OrderModel.fromJson(result.data["order"]), result.data["message"]));
    }
  }

  validate(BuildContext context, ShipByGlobalEntity data) {
    if (data.senderAddress.latitude == null) {
      emit(ShipByGlobalErrorState(context.tr.please_select_sender_address_from_map));
      return false;
    }
    if (data.receiverAddress.latitude == null) {
      emit(ShipByGlobalErrorState(context.tr.please_select_receiver_address_from_map));
      return false;
    }
    return true;
  }

  payment(int id, Map<String, dynamic> values) async {
    emit(ShipByGlobalLoadingState());
    final result = await repository.payment(id, values);
    if (result.errorMessages != null) {
      emit(ShipByGlobalErrorState(result.errorMessages!));
    } else if (result.errors != null) {
      emit(ShipByGlobalErrorState(result.errors!));
    } else {
      emit(const ShipByGlobalPaymentState(""));
    }
  }
}
