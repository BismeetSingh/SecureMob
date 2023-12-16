// To parse this JSON data, do
//
//     final displayCommandModel = displayCommandModelFromJson(jsonString);

import 'dart:convert';

DisplayCommandModel displayCommandModelFromJson(String str) =>
    DisplayCommandModel.fromJson(json.decode(str));

String displayCommandModelToJson(DisplayCommandModel data) =>
    json.encode(data.toJson());

class DisplayCommandModel {
  DisplayCommandModel({
    required this.id,
    required this.title,
  });

  String id;
  String title;

  factory DisplayCommandModel.fromJson(Map<String, dynamic> json) =>
      DisplayCommandModel(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
