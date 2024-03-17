import 'package:shoplo_client/features/notification/domain/entities/notification.dart';

import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
   NotificationModel({
    required super.id,
    required super.target,
    required super.user,
    required super.createdAt,
    required super.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
      id: json["id"],
      target: json["target"],
      data: Notification.fromJson(json["data"]),
      user: User.fromJson(json["user"]),
      createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "target": target,
        "data": data.toJson(),
        "user": user.toJson(),
        "created_at": createdAt,
      };
}
