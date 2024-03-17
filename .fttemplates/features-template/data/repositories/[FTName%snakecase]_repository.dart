import 'package:shoplo_client/core/core_model/app_response.dart';
import '../../domain/repositories/<FTName | snakecase>_interface.dart';
import '../datasources/<FTName | snakecase>_data_provider.dart';

class <FTName | pascalcase>Repository implements <FTName | pascalcase>Interface {
  final <FTName | pascalcase>DataProvider <FTName | camelcase>DataProvider;
  <FTName | pascalcase>Repository(this.<FTName | camelcase>DataProvider);

  @override
  Future<AppResponse> get() {
    return <FTName | camelcase>DataProvider.get();
  }
  
}
