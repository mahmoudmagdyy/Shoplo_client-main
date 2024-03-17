// To parse this JSON data, do
//
//     final uploaderModel = uploaderModelFromJson(jsonString);

import 'dart:convert';

List<UploaderModel> uploaderModelFromJson(String str) => List<UploaderModel>.from(json.decode(str).map((x) => UploaderModel.fromJson(x)));

String uploaderModelToJson(List<UploaderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UploaderModel {
  UploaderModel({
    this.name,
    this.file,
    this.type,
    this.folder,
  });

  String ?name;
  String ?file;
  String ?type;
  String ?folder;

  factory UploaderModel.fromJson(Map<String, dynamic> json) => UploaderModel(
    name: json["name"],
    file: json["file"],
    type: json["type"],
    folder: json["folder"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "file": file,
    "type": type,
    "folder": folder,
  };
}
