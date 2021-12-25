// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dzikirapp/db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class SettingsModel extends ChangeNotifier {
  late bool _dzikirReference = true;
  final DatabaseHandler handler = DatabaseHandler();

  void setDzikirReference(bool value) {
    print('value');
    print(value);
    _dzikirReference = value;
    notifyListeners();
  }

  initDzikirReference() {
    this.handler.retrieveSettingsByCode('dzikir_default').then((data) {
      _dzikirReference = data.active == 1;

      return data.active == 1;
    }, onError: (e) {
      print(e);
    });
  }

  get dzikirReference => _dzikirReference;

  Future<bool> get fetchSetting {
    final address =
        this.handler.retrieveSettingsByCode('dzikir_default').then((data) {
      _dzikirReference = data.active == 1;

      return data.active == 1;
    }, onError: (e) {
      print(e);
    });
    return address;
  }
}

class Secret {
  final String apiKey;
  Secret({this.apiKey = ""});
  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(apiKey: jsonMap["api_key"]);
  }
}

class SecretLoader {
  final String secretPath;

  SecretLoader({required this.secretPath});
  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(this.secretPath,
        (jsonStr) async {
      final secret = Secret.fromJson(json.decode(jsonStr));
      print(secret);
      return secret;
    });
  }
}
