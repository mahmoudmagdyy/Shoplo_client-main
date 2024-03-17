import 'language.dart';

class Notification {
  Notification({
    required this.ar,
    required this.en,
    required this.image,
    required this.senderName,
    required this.senderType,
    required this.modelId,
    required this.type,
    required this.title,
    required this.body,
    required this.total,
    required this.status,
    required this.orderType,
  });

  final Lang ar;
  final Lang en;
  final String image;
  final String senderName;
  final String senderType;
  final int modelId;
  final String type;
  final String title;
  final String body;
  final String total;
  final String status;
  final String orderType;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        ar: Lang.fromJson(json["ar"]),
        en: Lang.fromJson(json["en"]),
        image: json["image"] ?? "",
        senderName: json["sender_name"] ?? "",
        senderType: json["sender_type"] ?? "",
        modelId: json["model_id"] ?? 0,
        type: json["type"] ?? "",
        title: json["title"],
        body: json["body"],
        total: json["total"] ?? "",
        status: json["status"] ?? "",
        orderType: json["order_type"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ar": ar.toJson(),
        "en": en.toJson(),
        "image": image,
        "sender_name": senderName,
        "sender_type": senderType,
        "model_id": modelId,
        "type": type,
        "title": title,
        "body": body,
        "total": total,
        "status": status,
        "order_type": orderType,
      };
}
