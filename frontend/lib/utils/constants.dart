//This file has all constant values like response code, API base url

import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String? SERVER_URI;

// Success
const SUCCESS = 200;

// Errors
const USER_INVALID_RESPONSE = 100;
const NO_INTERNET = 101;
const INVALID_FORMAT = 102;
const UNKNOWN_ERROR = 103;
const API_NOT_REACHABLE = 104;

const INVALID_BODY = 400;

//API Endpoints
const GET_COMMANDS_API = "/getCommands";
const EXECUTE_COMMANDS_API = "/runCommand";

//Objects
const STORAGE = FlutterSecureStorage();

//AES Key
SecretKey? AES_KEY;
