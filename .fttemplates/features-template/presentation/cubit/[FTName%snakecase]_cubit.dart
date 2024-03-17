import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/services/injection.dart';

import '../../data/repositories/<FTName | snakecase>_repository.dart';

part '<FTName | snakecase>_state.dart';

class <FTName | pascalcase>Cubit extends Cubit<<FTName | pascalcase>State> {
  <FTName | pascalcase>Cubit() : super(<FTName | pascalcase>Initial());

  static <FTName | pascalcase>Cubit get(context) => BlocProvider.of(context);

  final repository = serviceLocator.get<<FTName | pascalcase>Repository>();
 
}
