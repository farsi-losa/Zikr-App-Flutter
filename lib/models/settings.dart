// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dzikirapp/db.dart';
import 'package:flutter/foundation.dart';

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
