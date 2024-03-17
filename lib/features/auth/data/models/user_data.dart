import 'package:shoplo_client/features/auth/domain/entities/user_data.dart';
import '../../domain/entities/user.dart';

class UserDataModel extends UserDataEntity {
  const UserDataModel({
    required super.accessToken,
    // required super.tokenType,
    // required super.expiresIn,
    // required super.message,
    required super.user,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    accessToken: json["access_token"],
    // tokenType: json["token_type"],
    // expiresIn: json["expires_in"],
    // message: json["message"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    // "token_type": tokenType,
    // "expires_in": expiresIn,
    // "message": message,
    "user": user.toJson(),
  };
}
