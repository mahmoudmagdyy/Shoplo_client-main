import 'package:shoplo_client/core/core_model/app_response.dart';
import 'package:shoplo_client/features/addresses/data/data_source/address_data_provider.dart';

import '../../domain/repositories/address_interface.dart';

class AddressRepository extends AddressInterFace{
  final AddressProvider addressProvider;
  AddressRepository(this.addressProvider);

  @override
  Future<AppResponse> getMyAddresses() {
    return addressProvider.getMyAddresses();
  }

  @override
  Future<AppResponse> getAddressesDetails(id) {
    return addressProvider.getAddressesDetails(id);
  }

  @override
  Future<AppResponse> addAddressProfile(values) {
    return addressProvider.addAddressProfile(values);
  }

  @override
  Future<AppResponse> editAddressProfile(values,id) {
    return addressProvider.editAddressProfile(values,id);
  }

  @override
  Future<AppResponse> deleteAddress(int id) {
    return addressProvider.deleteAddress(id);
  }

  @override
  Future<AppResponse> getCountries(query) {
    return addressProvider.getCountries(query);
  }

  @override
  Future<AppResponse> getStates(id, query) {
    return addressProvider.getStates(id, query);
  }

  @override
  Future<AppResponse> getCities(id, query) {
    return addressProvider.getCities(id, query);
  }

}