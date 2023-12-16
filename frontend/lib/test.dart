import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';

void main() async {
  final algorithm = AesGcm.with256bits();
  final key = await algorithm.newSecretKeyFromBytes(
    utf8.encode("4u7x!A%D*G-KaPdRgUkXp2s5v8y/B?E("),
  );

  final secretBox = await algorithm.encrypt(
    utf8.encode("Hello"),
    secretKey: key,
  );

  debugPrint(secretBox.cipherText.toString());
}
