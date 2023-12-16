// To parse this JSON data, do
//
//     final commandExecutionResultModel = commandExecutionResultModelFromJson(jsonString);

import 'dart:convert';

CommandExecutionResultModel commandExecutionResultModelFromJson(String str) =>
    CommandExecutionResultModel.fromJson(json.decode(str));

String commandExecutionResultModelToJson(CommandExecutionResultModel data) =>
    json.encode(data.toJson());

class CommandExecutionResultModel {
  CommandExecutionResultModel({
    required this.executionResult,
    required this.apiStatusCode,
    required this.httpStatusCode,
  });

  String executionResult;
  String apiStatusCode;
  String httpStatusCode;

  factory CommandExecutionResultModel.fromJson(Map<String, dynamic> json) =>
      CommandExecutionResultModel(
        executionResult: json["executionResult"],
        apiStatusCode: json["apiStatus"],
        httpStatusCode: json["httpStatus"],
      );

  Map<String, dynamic> toJson() => {
        "executionResult": executionResult,
        "apiStatus": apiStatusCode,
        "httpStatus": httpStatusCode,
      };
}
