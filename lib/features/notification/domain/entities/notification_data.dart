// import 'language.dart';
//
// class NotificationData {
//   NotificationData({
//     required this.ar,
//     required this.en,
//     required this.modelId,
//     required this.total,
//     required this.type,
//     required this.status,
//     required this.title,
//     required this.body,
//   });
//
//   final Lang ar;
//   final Lang en;
//   final int modelId;
//   final String total;
//   final String type;
//   final String status;
//   final String title;
//   final String body;
//
//   factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
//     ar: Lang.fromJson(json["ar"]),
//     en: Lang.fromJson(json["en"]),
//     modelId: json["model_id"],
//     total: json["total"],
//     type: json["type"],
//     status: json["status"],
//     title: json["title"],
//     body: json["body"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "ar": ar.toJson(),
//     "en": en.toJson(),
//     "model_id": modelId == null ? null : modelId,
//     "total": total == null ? null : total,
//     "type": type,
//     "status": status == null ? null : status,
//     "title": title,
//     "body": body,
//   };
// }