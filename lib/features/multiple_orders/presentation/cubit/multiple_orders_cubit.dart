import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/services/injection.dart';
import 'package:shoplo_client/features/addresses/data/repositories/address_repository.dart';
import 'package:shoplo_client/features/addresses/domain/entities/state.dart';

import '../../../../widgets/app_snack_bar.dart';
import '../../../addresses/domain/entities/city.dart';
import '../../../addresses/domain/entities/country.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../data/models/multiple_order_total.dart';
import '../../data/repositories/multiple_orders_repository.dart';
import '../../domain/request/create_mutiple_order_request.dart';

part 'multiple_orders_state.dart';

class MultipleOrdersCubit extends Cubit<MultipleOrdersState> {
  MultipleOrdersCubit() : super(MultipleOrdersInitial());

  static MultipleOrdersCubit get(context) => BlocProvider.of(context);

  final repository = serviceLocator.get<MultipleOrdersRepository>();
  final addressRepo = serviceLocator.get<AddressRepository>();
  CreateMultipleOrderRequest createRequest = CreateMultipleOrderRequest();
  initRequest(BuildContext context) {
    createRequest.stores.add(OrderDescriptionModel());
    createRequest.stores.add(OrderDescriptionModel());
    if (context.read<UserCubit>().userData?.user.addresses.isNotEmpty ??
        false) {
      createRequest.toAddress =
          context.read<UserCubit>().userData?.user.addresses.first;
    }
  }

  Future<List<Country>?> geCountry() async {
    final result = await addressRepo.getCountries({});
    if (result.errorMessages != null) {
      emit(MultipleOrdersErrorState(result.errorMessages!));
    } else if (result.errors != null) {
      emit(MultipleOrdersErrorState(result.errors!));
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
      emit(MultipleOrdersErrorState(result.errorMessages!));
    } else if (result.errors != null) {
      emit(MultipleOrdersErrorState(result.errors!));
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
      emit(MultipleOrdersErrorState(result.errorMessages!));
    } else if (result.errors != null) {
      emit(MultipleOrdersErrorState(result.errors!));
    } else {
      List<City> cites = [];
      result.data!.forEach((element) {
        cites.add(City.fromJson(element));
      });
      return cites;
    }
    return null;
  }

  refreshFields(String type) {
    emit(MultipleOrdersRefreshFieldsState(type));
  }

  addOrderDescription() {
    createRequest.stores.insert(0, OrderDescriptionModel());
    emit(MultipleOrdersAddOrderDescriptionState(createRequest.stores.length));
  }

  removeOrderDescription(OrderDescriptionModel model) {
    if (createRequest.stores.length == 2) return;
    createRequest.stores.remove(model);
    emit(
        MultipleOrdersRemoveOrderDescriptionState(createRequest.stores.length));
  }

  validateTime(BuildContext context) {
    if (createRequest.from != null && createRequest.to != null) {
      if (createRequest.from!.isAfter(createRequest.to!)) {
        AppSnackBar.showError((context.tr.from_time_must_be_before_to_time));
        return false;
      }
      return true;
    }
    return true;
  }

  previewOrder() async {
    emit(MultipleOrdersPreviewOrderLoadingState());
    final result = await repository.previewOrder(createRequest.toJson());
    if (result.errorMessages != null) {
      emit(MultipleOrdersErrorState(result.errorMessages!));
    } else if (result.errors != null) {
      emit(MultipleOrdersErrorState(result.errors!));
    } else {
      log(result.data.toString());
      createRequest.total = MultipleOrderTotal.fromJson(result.data!);
      emit(MultipleOrdersPreviewOrderSuccessState(createRequest));
    }
  }
}
