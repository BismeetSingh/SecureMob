/*
This file has code to communicate with API's. All communication is done via POST requests.

Initially was done with dart:Isolates, however due to Flutter web not supporting it, was replaced with async calls.

Do not modify unless you know what you're doing.
*/

import 'dart:convert';
import 'dart:io';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/api_status.dart';
import '../../utils/constants.dart';

Future<dynamic> postRequest({required String url, Object body = ""}) async {
  debugPrint("API_URL");
  debugPrint(SERVER_URI);

  final uri = Uri.parse(SERVER_URI! + url);

  if (body == "") {
    body = jsonEncode({});
  } else {
    body = jsonEncode(body);
  }

  final algorithm = AesGcm.with256bits();
  final encryptionNonce = algorithm.newNonce();

  //Encrypting API body using AES
  final secretBox = await algorithm.encrypt(
    utf8.encode(body.toString()),
    secretKey: AES_KEY!,
    nonce: encryptionNonce,
  );

  //Combining ciphertext, nonce and MAC
  var combined = [...secretBox.cipherText, ...secretBox.mac.bytes].toList();

  //Base64 encoding the request body
  final requestBody = base64Encode(
    utf8.encode(
      "${base64Encode(encryptionNonce)}.${base64Encode(combined)}",
    ),
  );
  debugPrint(requestBody);

  try {
    var response = await http.post(
      uri,
      body: requestBody,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
      },
    );

    //Decoding the base64 response
    final rawBody = utf8.decode(
      //Response is a string which might have quotes around, they are removed
      base64.decode(
        response.body.replaceAll("\"", ""),
      ),
    );

    //Splitting the response to get ciphertext and nonce
    final chunks = rawBody.split(".");
    final decryptionNonce = base64.decode(chunks[0]).toList();
    var encryptedResponse = base64.decode(chunks[1]).toList();

    //MAC is the last 16 bytes of the ciphertext
    var mac = encryptedResponse.sublist(encryptedResponse.length - 16);
    encryptedResponse =
        encryptedResponse.sublist(0, encryptedResponse.length - 16);

    //Decrypting the ciphertext to get the API response
    final decryptedBody = await algorithm.decrypt(
      SecretBox(
        encryptedResponse,
        nonce: decryptionNonce,
        mac: Mac(mac),
      ),
      secretKey: AES_KEY!,
    );

    //API Responses are sent out as objects of Success, Failure
    if (response.statusCode == SUCCESS) {
      return Success(
        response: http.Response(
          utf8.decode(decryptedBody),
          response.statusCode,
        ),
        code: SUCCESS,
      );
    }
    return Failure(
      code: USER_INVALID_RESPONSE,
      errorResponse: 'Invalid Response${utf8.decode(decryptedBody)}',
    );
  } on HttpException {
    return Failure(code: NO_INTERNET, errorResponse: 'No Internet Connection');
  } on SocketException {
    return Failure(code: API_NOT_REACHABLE, errorResponse: 'API Not Reachable');
  } on FormatException {
    return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
  } catch (e, s) {
    debugPrint(e.toString());
    debugPrint(s.toString());
    return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
  }
}
