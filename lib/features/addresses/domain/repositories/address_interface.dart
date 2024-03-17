import '../../../../core/core_model/app_response.dart';

abstract class AddressInterFace {

  Future<AppResponse> getMyAddresses();
  Future<AppResponse> getAddressesDetails(id);
  Future<AppResponse> addAddressProfile(values);
  Future<AppResponse> editAddressProfile(values,id);
  Future<AppResponse> deleteAddress(int id);

  ///dropdown
  Future<AppResponse> getCountries(Map<String, String>? query);
  Future<AppResponse> getStates(id, Map<String, String>? query);
  Future<AppResponse> getCities(id, Map<String, String>? query);
}