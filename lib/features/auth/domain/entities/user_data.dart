import 'package:equatable/equatable.dart';
import 'package:shoplo_client/features/auth/domain/entities/user.dart';

class UserDataEntity extends Equatable {
  const UserDataEntity({
     required this.accessToken,
     // required this.tokenType,
     // required this.expiresIn,
     // required this.message,
     required this.user,
  });

  final String accessToken;
  // final String tokenType;
  // final int expiresIn;
  // final String message;
  final User user;

  @override
  // TODO: implement props
  List<Object?> get props => [accessToken/*,tokenType,expiresIn,message,*/,user];

}

