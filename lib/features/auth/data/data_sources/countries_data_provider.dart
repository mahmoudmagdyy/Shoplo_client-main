import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';

class CountriesDataProvider {
  Future<AppResponse> getCountries(bool all) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.countries,
      query: {'all': all ? '1' : '0'},
    ).then(
      (value) {
        response = AppResponse.fromJson({'data': value.data});
      },
    ).catchError(
      (error) {
        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }
}
