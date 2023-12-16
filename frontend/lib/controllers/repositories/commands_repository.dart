//Has functions that interact with API
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:SecureXccess/models/display_command_model.dart';
import 'package:SecureXccess/utils/constants.dart';

import '../../utils/api_status.dart';
import '../generics/api_communicator.dart';

class CommandsRepository {
  //Fetches commands from API
  Future<List<DisplayCommandModel>> getCommandsFromAPI() async {
    var result = await postRequest(url: GET_COMMANDS_API);

    if (result is Failure) {
      debugPrint(result.errorResponse.toString());
      throw Exception(result.errorResponse);
    }

    final response = result.response as http.Response;
    var body = json.decode(response.body);

    //List of commands
    final List<DisplayCommandModel> commands = [];

    if (body['payload'] == null) {
      return commands;
    }

    //Making command objects from received data.
    for (var i = 0; i < body['payload'].length; i++) {
      commands.add(
        DisplayCommandModel(
          id: body['payload'][i]['id'],
          title: body['payload'][i]['title'],
        ),
      );
    }
    return commands;
  }

  //Sends command execution request
  Future<Map<String, String>> executeCommand(String commandId) async {
    final result = await postRequest(
      url: EXECUTE_COMMANDS_API,
      //Only command ID is sent to server
      body: {"commandId": commandId},
    );

    if (result is Failure) {
      debugPrint(result.errorResponse.toString());
      throw Exception({
        "executionResult": result.errorResponse.toString(),
        "apiStatusCode": 0,
        "httpStatusCode": result.code.toString(),
      });
    }

    final response = result.response as http.Response;
    var body = json.decode(response.body);

    debugPrint("COMMANDS_EXECUTION_RESULT");
    debugPrint(body.toString());

    return {
      "executionResult": body['payload'][0]['output'].toString(),
      "apiStatusCode": body['status'].toString(),
      "httpStatusCode": response.statusCode.toString(),
    };
  }
}

/*
Response format
{
  message: Command Executed Successfully,
  payload: [{output: 'hi' }],
  status: 1
}

*/
