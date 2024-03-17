import 'package:equatable/equatable.dart';
import 'package:shoplo_client/features/notification/domain/entities/notification.dart';
import '../../../auth/domain/entities/user.dart';

class NotificationEntity extends Equatable {
  NotificationEntity({
    required this.id,
    required this.target,
    required this.data,
    required this.user,
    required this.createdAt,
  });

  final String id;
  final String target;
  final Notification data;
  final User user;
  final String createdAt;

  factory NotificationEntity.fromJson(Map<String, dynamic> json) => NotificationEntity(
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

  @override
  List<Object?> get props => [id, target, user, createdAt];
}



