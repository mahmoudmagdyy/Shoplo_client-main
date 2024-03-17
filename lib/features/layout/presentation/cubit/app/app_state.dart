part of 'app_cubit.dart';

@immutable
abstract class AppStates {}

class AppInitial extends AppStates {}

class AppChangeModeState extends AppStates {}

class AppLanguageState extends AppStates {}

class RefreshOrderState extends AppStates {}
